## BattleManager - Manages all battle logic, turns, damage calculation
extends Node

# Battle state
enum BattlePhase {
	NONE,
	START,
	PLAYER_TURN,
	ENEMY_TURN,
	RESOLUTION,
	END
}

var battle_phase: BattlePhase = BattlePhase.NONE
var is_battle_active: bool = false
var is_wild_battle: bool = false
var current_turn: int = 0

# Battle participants
var player_team: Array = []  # Array of Solamon instances (max 6)
var enemy_team: Array = []  # Array of Solamon instances (max 6)
var active_player_index: int = 0
var active_enemy_index: int = 0

# Resonance meter (0-100)
var resonance_meter: float = 0.0
const RESONANCE_THRESHOLDS = [50.0, 75.0, 100.0]
var active_resonance_bonuses: Array = []

# Battle settings
var battle_type: String = "single"  # "single", "double", "trainer", "wild"
var can_flee: bool = true
var can_switch: bool = true
var apex_used_this_battle: bool = false

# Turn order queue
var turn_order: Array = []

# Signals
signal battle_started(player_team: Array, enemy_team: Array)
signal turn_started(solamon: Dictionary, is_player: bool)
signal move_executed(user: Dictionary, target: Dictionary, move: Dictionary, result: Dictionary)
signal solamon_fainted(solamon: Dictionary, is_player: bool)
signal battle_ended(result: String)  # "win", "lose", "flee", "catch"
signal resonance_changed(value: float)
signal apex_activated(solamon: Dictionary)

# Battle log
var battle_log: Array = []

func _ready() -> void:
	print("[BattleManager] Initialized")

# ---- BATTLE INITIALIZATION ----

func start_battle(player_solamons: Array, enemy_solamons: Array, wild: bool = false) -> void:
	player_team = player_solamons.duplicate(true)
	enemy_team = enemy_solamons.duplicate(true)
	is_wild_battle = wild
	is_battle_active = true
	current_turn = 0
	resonance_meter = 0.0
	active_resonance_bonuses.clear()
	battle_log.clear()
	apex_used_this_battle = false

	# Find first non-fainted Solamon on each side
	active_player_index = _find_first_alive(player_team)
	active_enemy_index = _find_first_alive(enemy_team)

	battle_phase = BattlePhase.START
	can_flee = wild  # Can only flee from wild battles
	can_switch = true

	add_log("Battle started!")
	battle_started.emit(player_team, enemy_team)

func start_wild_encounter(species_id: String, level: int) -> void:
	var wild_solamon = DataManager.get_solamon_at_level(species_id, level)
	start_battle(
		GameManager.solarlink_data["active_team"].map(func(id): return GameManager.get_solamon(id)),
		[wild_solamon],
		true
	)

func start_trainer_battle(enemy_team_data: Array) -> void:
	var player_solamons = []
	for id in GameManager.solarlink_data["active_team"]:
		var sol = GameManager.get_solamon(id)
		if not sol.is_empty():
			player_solamons.append(sol)
	start_battle(player_solamons, enemy_team_data, false)

# ---- TURN MANAGEMENT ----

func begin_player_turn() -> void:
	battle_phase = BattlePhase.PLAYER_TURN
	var player_active = get_active_player()
	if player_active.is_empty():
		_check_battle_end()
		return
	turn_started.emit(player_active, true)

func execute_player_action(action: Dictionary) -> void:
	"""Execute a player action: {type: "move"|"switch"|"item"|"flee", data: {...}}"""
	match action["type"]:
		"move":
			_execute_move(get_active_player(), get_active_enemy(), action["data"]["move_id"], true)
		"switch":
			_switch_solamon(true, action["data"]["index"])
		"item":
			_use_item(action["data"]["item_id"], action["data"].get("target_index", active_player_index))
		"flee":
			_attempt_flee()

func begin_enemy_turn() -> void:
	battle_phase = BattlePhase.ENEMY_TURN
	var enemy_active = get_active_enemy()
	if enemy_active.is_empty():
		_check_battle_end()
		return
	turn_started.emit(enemy_active, false)

	# Simple AI: pick best move
	var move_id = _choose_enemy_move(enemy_active, get_active_player())
	_execute_move(enemy_active, get_active_player(), move_id, false)

# ---- MOVE EXECUTION ----

func _execute_move(user: Dictionary, target: Dictionary, move_id: String, is_player: bool) -> void:
	var move = DataManager.get_move(move_id)
	if move.is_empty():
		add_log("Unknown move!")
		_advance_turn()
		return

	add_log(user["name"] + " used " + move["name"] + "!")

	# Check accuracy
	var accuracy = move["accuracy"]
	if randf() * 100.0 > accuracy:
		add_log(user["name"] + "'s attack missed!")
		_add_resonance(3.0)
		_advance_turn()
		return

	# Calculate and apply effects
	var result = {"damage": 0, "status_applied": "", "healing": 0, "critical": false, "effective": ""}

	if move["category"] == "status":
		_apply_status_effect(user, move, is_player)
		result["healing"] = _apply_healing(user, move, is_player)
	else:
		result["damage"] = _calculate_damage(user, target, move)
		result["critical"] = _check_critical()

		if result["critical"]:
			add_log("Critical hit!")

		# Apply Aspect effectiveness
		var effectiveness = _get_effectiveness(move["aspect"], target["aspects"])
		result["effective"] = _get_effectiveness_text(effectiveness)
		result["damage"] = int(result["damage"] * effectiveness)

		# Apply damage
		target["current_vit"] = max(0, target["current_vit"] - result["damage"])

		# Check secondary effects
		if move.has("effect") and move["effect"] != null:
			_apply_secondary_effect(target, move["effect"], is_player)

		# Add resonance
		_add_resonance(5.0 + result["damage"] * 0.1)

	# Log results
	if result["damage"] > 0:
		add_log(target["name"] + " took " + str(result["damage"]) + " damage!")
	if result["effective"] != "":
		add_log(result["effective"])
	if result["status_applied"] != "":
		add_log(target["name"] + " is " + result["status_applied"] + "!")

	# Check for faint
	if target["current_vit"] <= 0:
		add_log(target["name"] + " fainted!")
		solamon_fainted.emit(target, target in player_team)

	# Check for evolution
	if is_player and user.get("level", 0) > 0:
		var evo_target = DataManager.check_evolution(user)
		if evo_target != "":
			add_log(user["name"] + " is evolving!")
			_evolve_solamon(user, evo_target)

	move_executed.emit(user, target, move, result)

	# Check battle end
	if _check_battle_end():
		return

	_advance_turn()

func _calculate_damage(attacker: Dictionary, defender: Dictionary, move: Dictionary) -> int:
	"""Core damage formula"""
	if move["power"] <= 0:
		return 0

	var level = attacker["level"]
	var power_stat = attacker["stats"]["power"] if move["category"] == "physical" else attacker["stats"]["focus"]
	var defense_stat = defender["stats"]["guard"] if move["category"] == "physical" else defender["stats"]["resolve"]

	# Base damage
	var base = ((2.0 * level / 5.0 + 2.0) * move["power"] * power_stat / max(defense_stat, 1)) / 50.0 + 2.0

	# Apply resonance bonuses
	var res_bonus = _get_resonance_damage_bonus()
	base *= res_bonus

	# Apply Harmony bonus
	var harmony_bonus = 1.0 + (attacker.get("harmony", 0) / 1500.0) * 0.15
	base *= harmony_bonus

	# Apply innate trait bonuses
	base *= _get_trait_damage_modifier(attacker, move)

	# Apply stat bonuses from items/effects
	var stat_bonus = 1.0 + attacker.get("stat_bonuses", {}).get("power" if move["category"] == "physical" else "focus", 0) * 0.1
	base *= stat_bonus

	# Random factor (0.85 - 1.0)
	base *= randf_range(0.85, 1.0)

	return max(1, int(base))

func _check_critical() -> bool:
	return randf() < 0.0625  # 6.25% base crit chance

func _get_effectiveness(move_aspect: String, defender_aspects: Array) -> float:
	if move_aspect == "Neutral":
		return 1.0
	var multiplier = 1.0
	for aspect in defender_aspects:
		multiplier *= DataManager.get_aspect_multiplier(move_aspect, aspect)
	return multiplier

func _get_effectiveness_text(effectiveness: float) -> String:
	if effectiveness >= 2.0:
		return "It's super effective!"
	elif effectiveness > 1.0:
		return "It's effective."
	elif effectiveness < 0.5:
		return "It has no effect..."
	elif effectiveness < 1.0:
		return "It's not very effective..."
	return ""

# ---- STATUS EFFECTS ----

func _apply_status_effect(user: Dictionary, move: Dictionary, is_player: bool) -> void:
	if move["effect"] == null:
		return
	var effect = move["effect"]
	match effect.get("type", ""):
		"guard_up":
			user.get("stat_bonuses", {})["guard"] = user.get("stat_bonuses", {}).get("guard", 0) + effect.get("stages", 1)
			add_log(user["name"] + "'s Guard rose!")
		"resolve_up":
			user.get("stat_bonuses", {})["resolve"] = user.get("stat_bonuses", {}).get("resolve", 0) + effect.get("stages", 1)
			add_log(user["name"] + "'s Resolve rose!")
		"haste_up":
			user.get("stat_bonuses", {})["haste"] = user.get("stat_bonuses", {}).get("haste", 0) + effect.get("stages", 1)
			add_log(user["name"] + "'s Haste rose!")
		"power_up":
			user.get("stat_bonuses", {})["power"] = user.get("stat_bonuses", {}).get("power", 0) + effect.get("stages", 1)
			add_log(user["name"] + "'s Power rose!")
		"guard_resolve_up":
			user.get("stat_bonuses", {})["guard"] = user.get("stat_bonuses", {}).get("guard", 0) + effect.get("stages", 1)
			user.get("stat_bonuses", {})["resolve"] = user.get("stat_bonuses", {}).get("resolve", 0) + effect.get("stages", 1)
			add_log(user["name"] + "'s Guard and Resolve rose!")

func _apply_healing(user: Dictionary, move: Dictionary, is_player: bool) -> int:
	if move["effect"] == null:
		return 0
	var effect = move["effect"]
	var heal_amount = 0
	match effect.get("type", ""):
		"heal":
			heal_amount = int(user["stats"]["vitality"] * effect.get("percent", 0) / 100.0)
			user["current_vit"] = min(user["stats"]["vitality"], user["current_vit"] + heal_amount)
			add_log(user["name"] + " recovered " + str(heal_amount) + " Vitality!")
		"regen":
			add_log(user["name"] + " is regenerating!")
		"heal_all_allies":
			var team = player_team if is_player else enemy_team
			for sol in team:
				if sol["current_vit"] > 0:
					heal_amount = int(sol["stats"]["vitality"] * effect.get("percent", 0) / 100.0)
					sol["current_vit"] = min(sol["stats"]["vitality"], sol["current_vit"] + heal_amount)
			if effect.get("clear_status", false):
				for sol in team:
					sol["status_conditions"] = []
			add_log("The team was healed!")
	return heal_amount

func _apply_secondary_effect(target: Dictionary, effect: Dictionary, from_player: bool) -> void:
	if not effect.has("type"):
		return
	var chance = effect.get("chance", 100)
	if randf() * 100.0 > chance:
		return
	match effect["type"]:
		"burn", "shock", "frozen", "poisoned", "confused", "blinded", "rooted", "weakened":
			if effect["type"] not in target["status_conditions"]:
				target["status_conditions"].append(effect["type"])
				add_log(target["name"] + " is " + effect["type"] + "!")
		"guard_down":
			target.get("stat_bonuses", {})["guard"] = target.get("stat_bonuses", {}).get("guard", 0) - effect.get("stages", 1)
		"resolve_down":
			target.get("stat_bonuses", {})["resolve"] = target.get("stat_bonuses", {}).get("resolve", 0) - effect.get("stages", 1)
		"haste_down":
			target.get("stat_bonuses", {})["haste"] = target.get("stat_bonuses", {}).get("haste", 0) - effect.get("stages", 1)
		"power_down":
			target.get("stat_bonuses", {})["power"] = target.get("stat_bonuses", {}).get("power", 0) - effect.get("stages", 1)

# ---- ENEMY AI ----

func _choose_enemy_move(enemy: Dictionary, target: Dictionary) -> String:
	"""Simple AI: pick the move that does most expected damage"""
	var best_move = ""
	var best_score = -1.0

	for move_id in enemy["moves"]:
		var move = DataManager.get_move(move_id)
		if move.is_empty():
			continue
		if move["category"] == "status":
			# Prefer status moves at lower HP
			if enemy["current_vit"] < enemy["stats"]["vitality"] * 0.4:
				return move_id
			continue
		var effectiveness = _get_effectiveness(move["aspect"], target["aspects"])
		var score = move["power"] * effectiveness * (move["accuracy"] / 100.0)
		if score > best_score:
			best_score = score
			best_move = move_id

	return best_move if best_move != "" else enemy["moves"][0] if enemy["moves"].size() > 0 else ""

# ---- SWITCHING / ITEMS / FLEE ----

func _switch_solamon(is_player: bool, new_index: int) -> void:
	if is_player:
		var old_sol = get_active_player()
		active_player_index = new_index
		add_log("Go, " + get_active_player()["name"] + "!")
	else:
		active_enemy_index = new_index
		add_log("Enemy sent out " + get_active_enemy()["name"] + "!")

func _use_item(item_id: String, target_index: int) -> void:
	var item = DataManager.get_item(item_id)
	if item.is_empty():
		return
	if not GameManager.remove_item(item_id):
		add_log("No items left!")
		return

	add_log("Used " + item["name"] + "!")
	var target = player_team[target_index]

	match item["type"]:
		"heal":
			var effect = item["effect"]
			if effect.has("heal_vit"):
				target["current_vit"] = min(target["stats"]["vitality"], target["current_vit"] + effect["heal_vit"])
			if effect.has("heal_vit_percent"):
				target["current_vit"] = min(target["stats"]["vitality"], target["current_vit"] + int(target["stats"]["vitality"] * effect["heal_vit_percent"] / 100.0))
			if effect.get("clear_status", false):
				target["status_conditions"] = []
		"revive":
			var effect = item["effect"]
			target["current_vit"] = int(target["stats"]["vitality"] * effect.get("revive_vit_percent", 50) / 100.0)
			target["status_conditions"] = []
		"status_cure":
			var effect = item["effect"]
			if effect.get("cure_all", false):
				target["status_conditions"] = []
			elif effect.has("cure"):
				target["status_conditions"].erase(effect["cure"])
		"catch_boost":
			pass  # Handled in catch logic

	add_log(target["name"] + " was affected by the item!")
	_add_resonance(3.0)

func _attempt_flee() -> void:
	if not can_flee:
		add_log("Can't flee from this battle!")
		return

	var flee_chance = 0.6  # Base flee chance
	if randf() < flee_chance:
		add_log("Got away safely!")
		end_battle("flee")
	else:
		add_log("Couldn't escape!")
		_advance_turn()

# ---- CATCH MECHANIC ----

func attempt_catch() -> Dictionary:
	"""Attempt to catch the active wild Solamon. Returns {success: bool, message: String}"""
	if not is_wild_battle:
		return {"success": false, "message": "Can't catch trainer's Solamon!"}

	var enemy = get_active_enemy()
	var player_avg_level = _get_team_average_level(player_team)

	var item_mod = 1.0
	if GameManager.has_item("resonance_crystal"):
		GameManager.remove_item("resonance_crystal")
		item_mod = 1.5

	var catch_rate = DataManager.get_catch_rate(
		enemy["species_id"],
		enemy["level"],
		player_avg_level,
		item_mod
	)

	# Lower catch rate if enemy HP is higher
	var hp_factor = enemy["current_vit"] / float(enemy["stats"]["vitality"])
	catch_rate *= (1.0 - hp_factor * 0.5)

	if randf() < catch_rate:
		return {"success": true, "message": enemy["name"] + " was caught!"}
	else:
		return {"success": false, "message": enemy["name"] + " broke free!"}

# ---- APEX RESONANCE ----

func activate_apex_resonance(solamon_index: int) -> bool:
	"""Activate Apex Resonance for a Solamon"""
	if apex_used_this_battle:
		add_log("Apex Resonance already used this battle!")
		return false

	var solamon = player_team[solamon_index]
	var species = DataManager.get_solamon(solamon["species_id"])

	if not species.get("can_apex", false):
		add_log(species["name"] + " cannot use Apex Resonance!")
		return false

	if solamon.get("harmony", 0) < 1500:  # Level 6 Resonant
		add_log("Harmony is not high enough for Apex Resonance!")
		return false

	if not GameManager.has_item("apex_crystal"):
		add_log("No Apex Crystal!")
		return false

	# Apply Apex transformation
	var apex_data = species["apex_data"]
	solamon["is_apex"] = true
	solamon["name"] = apex_data["name"]

	# Boost stats
	var boost = apex_data["stat_boost"]
	for stat in solamon["stats"]:
		solamon["stats"][stat] = int(solamon["stats"][stat] * boost)
	solamon["current_vit"] = solamon["stats"]["vitality"]

	# Add apex move
	if apex_data.has("apex_move"):
		if solamon["moves"].size() < 4:
			solamon["moves"].append(apex_data["apex_move"])
		else:
			solamon["moves"][3] = apex_data["apex_move"]

	apex_used_this_battle = true
	_add_resonance(50.0)
	apex_activated.emit(solamon)
	add_log(solamon["name"] + " underwent APEX RESONANCE!")

	return true

# ---- BATTLE END ----

func _check_battle_end() -> bool:
	var player_alive = _count_alive(player_team)
	var enemy_alive = _count_alive(enemy_team)

	if enemy_alive <= 0:
		end_battle("win")
		return true
	elif player_alive <= 0:
		end_battle("lose")
		return true
	return false

func end_battle(result: String) -> void:
	is_battle_active = false
	battle_phase = BattlePhase.END

	match result:
		"win":
			add_log("You won the battle!")
			var exp_gained = _calculate_exp_reward()
			_distribute_exp(exp_gained)
			add_log("Gained " + str(exp_gained) + " EXP!")
		"lose":
			add_log("You lost the battle...")
		"flee":
			add_log("Escaped from battle.")
		"catch":
			add_log("Solamon caught!")

	battle_ended.emit(result)

	# Update Harmony for surviving Solamons
	if result == "win":
		for sol in player_team:
			if sol["current_vit"] > 0:
				sol["harmony"] = sol.get("harmony", 0) + 5

	# Save updated Solamon data back to GameManager
	_update_game_manager_solamons()

func _calculate_exp_reward() -> int:
	var total_exp = 0
	for enemy in enemy_team:
		var species = DataManager.get_solamon(enemy["species_id"])
		total_exp += species.get("exp_yield", 50) * enemy["level"] / 7
	return max(1, total_exp)

func _distribute_exp(exp_amount: int) -> void:
	for sol in player_team:
		if sol["current_vit"] <= 0:
			continue
		sol["exp"] = sol.get("exp", 0) + exp_amount
		_check_level_up(sol)

func _check_level_up(solamon: Dictionary) -> void:
	var next_level_exp = DataManager.get_exp_for_level(solamon["level"] + 1)
	while solamon["exp"] >= next_level_exp and solamon["level"] < 100:
		solamon["level"] += 1
		var species = DataManager.get_solamon(solamon["species_id"])
		solamon["stats"] = DataManager._calculate_stats_at_level(species["base_stats"], solamon["level"])
		add_log(solamon["name"] + " grew to level " + str(solamon["level"]) + "!")

		# Check for new moves
		for move_entry in species["moves_learnable"]:
			if move_entry["level"] == solamon["level"]:
				if solamon["moves"].size() < 4:
					solamon["moves"].append(move_entry["move_id"])
					var move = DataManager.get_move(move_entry["move_id"])
					add_log(solamon["name"] + " learned " + move["name"] + "!")

		next_level_exp = DataManager.get_exp_for_level(solamon["level"] + 1)

		# Check evolution
		var evo_target = DataManager.check_evolution(solamon)
		if evo_target != "":
			_evolve_solamon(solamon, evo_target)

func _evolve_solamon(solamon: Dictionary, target_species_id: String) -> void:
	var old_name = solamon["name"]
	var target_species = DataManager.get_solamon(target_species_id)
	solamon["species_id"] = target_species_id
	solamon["name"] = target_species["name"]
	solamon["aspects"] = target_species["aspects"].duplicate()
	solamon["innate_trait"] = target_species["innate_trait"]
	solamon["stats"] = DataManager._calculate_stats_at_level(target_species["base_stats"], solamon["level"])
	solamon["current_vit"] = solamon["stats"]["vitality"]
	add_log(old_name + " evolved into " + solamon["name"] + "!")

# ---- RESONANCE METER ----

func _add_resonance(amount: float) -> void:
	resonance_meter = min(100.0, resonance_meter + amount)
	resonance_changed.emit(resonance_meter)

func _get_resonance_damage_bonus() -> float:
	var bonus = 1.0
	if resonance_meter >= 50.0:
		bonus += 0.05
	if resonance_meter >= 75.0:
		bonus += 0.10
	if resonance_meter >= 100.0:
		bonus += 0.15
	return bonus

func _get_trait_damage_modifier(attacker: Dictionary, move: Dictionary) -> float:
	var innate_trait = attacker.get("innate_trait", "")
	var modifier = 1.0
	match innate_trait:
		"kindling":
			if current_turn == 1 and move["aspect"] == "Ember":
				modifier = 1.15
		"blaze_surge":
			if attacker["current_vit"] > attacker["stats"]["vitality"] * 0.5 and move["aspect"] == "Ember":
				modifier = 1.20
		"solar_reign":
			if move["aspect"] in ["Ember", "Radiant"]:
				modifier = 1.10
		"storm_charge":
			if move["aspect"] == "Volt":
				modifier = 1.10  # Simplified - would check weather
		"camouflage_strike":
			if current_turn == 1:
				modifier = 1.30
		"ancient_warden":
			if move["aspect"] in ["Root", "Stone"]:
				modifier = 1.15
		"first_light":
			if move["aspect"] in ["Radiant", "Spirit"]:
				modifier = 1.15
	return modifier

# ---- UTILITY ----

func _advance_turn() -> void:
	current_turn += 1
	# Decay resonance slowly
	resonance_meter = max(0, resonance_meter - 2.0)
	resonance_changed.emit(resonance_meter)

	# Process status conditions
	_process_status_ticks()

	# Auto-select next alive Solamon if current fainted
	if get_active_player()["current_vit"] <= 0:
		var next = _find_first_alive(player_team)
		if next >= 0:
			active_player_index = next
	if get_active_enemy()["current_vit"] <= 0:
		var next = _find_first_alive(enemy_team)
		if next >= 0:
			active_enemy_index = next
			if is_wild_battle:
				# Wild Solamon fled
				end_battle("win")
				return

	if not _check_battle_end():
		begin_player_turn()

func _process_status_ticks() -> void:
	for team in [player_team, enemy_team]:
		for sol in team:
			if sol["current_vit"] <= 0:
				continue
			var to_remove = []
			for status in sol["status_conditions"]:
				match status:
					"burn":
						var dmg = int(sol["stats"]["vitality"] * 0.05)
						sol["current_vit"] = max(0, sol["current_vit"] - dmg)
						add_log(sol["name"] + " is hurt by burn!")
					"poisoned":
						var dmg = int(sol["stats"]["vitality"] * 0.08)
						sol["current_vit"] = max(0, sol["current_vit"] - dmg)
						add_log(sol["name"] + " is hurt by poison!")
			for status in to_remove:
				sol["status_conditions"].erase(status)

func _update_game_manager_solamons() -> void:
	for sol in player_team:
		if sol.has("instance_id"):
			for i in range(GameManager.solarlink_data["stored_solamons"].size()):
				if GameManager.solarlink_data["stored_solamons"][i]["instance_id"] == sol["instance_id"]:
					GameManager.solarlink_data["stored_solamons"][i] = sol
					break

func get_active_player() -> Dictionary:
	if active_player_index >= 0 and active_player_index < player_team.size():
		return player_team[active_player_index]
	return {}

func get_active_enemy() -> Dictionary:
	if active_enemy_index >= 0 and active_enemy_index < enemy_team.size():
		return enemy_team[active_enemy_index]
	return {}

func _find_first_alive(team: Array) -> int:
	for i in range(team.size()):
		if team[i]["current_vit"] > 0:
			return i
	return -1

func _count_alive(team: Array) -> int:
	var count = 0
	for sol in team:
		if sol["current_vit"] > 0:
			count += 1
	return count

func _get_team_average_level(team: Array) -> int:
	var total = 0
	var count = 0
	for sol in team:
		if sol["current_vit"] > 0:
			total += sol["level"]
			count += 1
	return int(total / max(count, 1))

func add_log(message: String) -> void:
	battle_log.append(message)
	print("[Battle] ", message)

func get_battle_log() -> Array:
	return battle_log
