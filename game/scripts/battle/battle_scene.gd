## BattleScene - Main battle UI controller
extends Control

# UI References
@onready var player_solamon_display: Control = $PlayerDisplay
@onready var enemy_solamon_display: Control = $EnemyDisplay
@onready var player_hp_bar: ProgressBar = $PlayerDisplay/HPBar
@onready var enemy_hp_bar: ProgressBar = $EnemyDisplay/HPBar
@onready var player_name_label: Label = $PlayerDisplay/NameLabel
@onready var enemy_name_label: Label = $EnemyDisplay/NameLabel
@onready var player_level_label: Label = $PlayerDisplay/LevelLabel
@onready var enemy_level_label: Label = $EnemyDisplay/LevelLabel
@onready var battle_log_label: RichTextLabel = $BattleLog
@onready var move_panel: Control = $MovePanel
@onready var message_label: Label = $MessageLabel
@onready var resonance_bar: ProgressBar = $ResonanceBar

# State
var awaiting_input: bool = false
var battle_initialized: bool = false

func _ready() -> void:
	# Connect battle signals
	BattleManager.battle_started.connect(_on_battle_started)
	BattleManager.turn_started.connect(_on_turn_started)
	BattleManager.move_executed.connect(_on_move_executed)
	BattleManager.solamon_fainted.connect(_on_solamon_fainted)
	BattleManager.battle_ended.connect(_on_battle_ended)
	BattleManager.resonance_changed.connect(_on_resonance_changed)
	BattleManager.apex_activated.connect(_on_apex_activated)

	# Hide move panel initially
	if move_panel:
		move_panel.visible = false

func _on_battle_started(player_team: Array, enemy_team: Array) -> void:
	battle_initialized = true
	_update_all_displays()
	_add_log("A wild Solamon appeared!" if BattleManager.is_wild_battle else "Trainer wants to battle!")

	# Start first turn
	await get_tree().create_timer(1.0).timeout
	BattleManager.begin_player_turn()

func _on_turn_started(solamon: Dictionary, is_player: bool) -> void:
	_update_all_displays()
	if is_player:
		awaiting_input = true
		_show_move_panel()
	else:
		awaiting_input = false
		_hide_move_panel()

func _on_move_executed(user: Dictionary, target: Dictionary, move: Dictionary, result: Dictionary) -> void:
	_add_log(user["name"] + " used " + move["name"] + "!")
	if result["damage"] > 0:
		_add_log(target["name"] + " took " + str(result["damage"]) + " damage!")
	if result["effective"] != "":
		_add_log(result["effective"])

	# Animate HP bars
	await get_tree().create_timer(0.5).timeout
	_update_all_displays()

	# Play move sound
	AudioManager.play_sfx("move_" + move["aspect"].to_lower())

func _on_solamon_fainted(solamon: Dictionary, is_player: bool) -> void:
	_add_log(solamon["name"] + " fainted!")
	_update_all_displays()

func _on_battle_ended(result: String) -> void:
	match result:
		"win":
			_add_log("You won!")
			_show_message("Victory! Gained EXP!")
		"lose":
			_add_log("You lost...")
			_show_message("Defeated...")
		"flee":
			_add_log("Got away safely!")
			_show_message("Escaped!")

	await get_tree().create_timer(2.0).timeout
	# Return to overworld
	GameManager.change_state(GameManager.GameState.OVERWORLD)
	queue_free()

func _on_resonance_changed(value: float) -> void:
	if resonance_bar:
		resonance_bar.value = value

func _on_apex_activated(solamon: Dictionary) -> void:
	_add_log("APEX RESONANCE ACTIVATED!")
	_add_log(solamon["name"] + " reached its peak power!")
	_update_all_displays()
	# Flash effect would go here

# ---- MOVE PANEL ----

func _show_move_panel() -> void:
	if not move_panel:
		return
	move_panel.visible = true

	# Clear existing move buttons
	for child in move_panel.get_children():
		if child is Button:
			child.queue_free()

	# Get current player Solamon's moves
	var player_sol = BattleManager.get_active_player()
	if player_sol.is_empty():
		return

	var button_y = 10
	for move_id in player_sol["moves"]:
		var move_data = DataManager.get_move(move_id)
		if move_data.is_empty():
			continue

		var btn = Button.new()
		btn.text = move_data["name"] + " [" + move_data["aspect"] + "] P:" + str(move_data["power"])
		btn.position = Vector2(10, button_y)
		btn.size = Vector2(200, 30)
		btn.pressed.connect(_on_move_selected.bind(move_id))
		move_panel.add_child(btn)
		button_y += 35

	# Add switch button
	var switch_btn = Button.new()
	switch_btn.text = "Switch"
	switch_btn.position = Vector2(220, 10)
	switch_btn.size = Vector2(80, 30)
	switch_btn.pressed.connect(_on_switch_pressed)
	move_panel.add_child(switch_btn)

	# Add item button
	var item_btn = Button.new()
	item_btn.text = "Items"
	item_btn.position = Vector2(220, 45)
	item_btn.size = Vector2(80, 30)
	item_btn.pressed.connect(_on_items_pressed)
	move_panel.add_child(item_btn)

	# Add flee button (only in wild battles)
	if BattleManager.is_wild_battle:
		var flee_btn = Button.new()
		flee_btn.text = "Flee"
		flee_btn.position = Vector2(220, 80)
		flee_btn.size = Vector2(80, 30)
		flee_btn.pressed.connect(_on_flee_pressed)
		move_panel.add_child(flee_btn)

	# Add catch button (only in wild battles)
	if BattleManager.is_wild_battle:
		var catch_btn = Button.new()
		catch_btn.text = "Catch"
		catch_btn.position = Vector2(220, 115)
		catch_btn.size = Vector2(80, 30)
		catch_btn.pressed.connect(_on_catch_pressed)
		move_panel.add_child(catch_btn)

	# Add Apex Resonance button (if conditions met)
	var player_sol_data = DataManager.get_solamon(player_sol["species_id"])
	if player_sol_data.get("can_apex", false) and not BattleManager.apex_used_this_battle:
		var apex_btn = Button.new()
		apex_btn.text = "APEX"
		apex_btn.position = Vector2(310, 10)
		apex_btn.size = Vector2(80, 30)
		apex_btn.modulate = Color(1.0, 0.8, 0.2)  # Gold color
		apex_btn.pressed.connect(_on_apex_pressed)
		move_panel.add_child(apex_btn)

func _hide_move_panel() -> void:
	if move_panel:
		move_panel.visible = false

func _on_move_selected(move_id: String) -> void:
	if not awaiting_input:
		return
	awaiting_input = false
	_hide_move_panel()
	BattleManager.execute_player_action({"type": "move", "data": {"move_id": move_id}})

func _on_switch_pressed() -> void:
	if not awaiting_input:
		return
	# Show team switch UI (simplified)
	awaiting_input = false
	_hide_move_panel()
	# For now, just switch to next alive Solamon
	for i in range(BattleManager.player_team.size()):
		if i != BattleManager.active_player_index and BattleManager.player_team[i]["current_vit"] > 0:
			BattleManager.execute_player_action({"type": "switch", "data": {"index": i}})
			return

func _on_items_pressed() -> void:
	if not awaiting_input:
		return
	# Show items UI (simplified - use first healing item)
	awaiting_input = false
	_hide_move_panel()
	for item_id in GameManager.solarlink_data["items"]:
		var item = DataManager.get_item(item_id)
		if item["category"] == "medicine" and item["type"] == "heal":
			BattleManager.execute_player_action({
				"type": "item",
				"data": {"item_id": item_id, "target_index": BattleManager.active_player_index}
			})
			return
	_show_message("No usable items!")
	awaiting_input = true
	_show_move_panel()

func _on_flee_pressed() -> void:
	if not awaiting_input:
		return
	awaiting_input = false
	_hide_move_panel()
	BattleManager.execute_player_action({"type": "flee", "data": {}})

func _on_catch_pressed() -> void:
	if not awaiting_input:
		return
	awaiting_input = false
	_hide_move_panel()
	var result = BattleManager.attempt_catch()
	_add_log(result["message"])
	if result["success"]:
		var enemy = BattleManager.get_active_enemy()
		GameManager.add_solamon(enemy)
		BattleManager.end_battle("catch")
	else:
		await get_tree().create_timer(1.0).timeout
		BattleManager.begin_enemy_turn()

func _on_apex_pressed() -> void:
	if not awaiting_input:
		return
	var success = BattleManager.activate_apex_resonance(BattleManager.active_player_index)
	if success:
		_update_all_displays()

# ---- DISPLAY UPDATES ----

func _update_all_displays() -> void:
	var player_sol = BattleManager.get_active_player()
	var enemy_sol = BattleManager.get_active_enemy()

	if not player_sol.is_empty():
		if player_name_label:
			player_name_label.text = player_sol["name"]
		if player_level_label:
			player_level_label.text = "Lv." + str(player_sol["level"])
		if player_hp_bar:
			player_hp_bar.max_value = player_sol["stats"]["vitality"]
			player_hp_bar.value = player_sol["current_vit"]

	if not enemy_sol.is_empty():
		if enemy_name_label:
			enemy_name_label.text = enemy_sol["name"]
		if enemy_level_label:
			enemy_level_label.text = "Lv." + str(enemy_sol["level"])
		if enemy_hp_bar:
			enemy_hp_bar.max_value = enemy_sol["stats"]["vitality"]
			enemy_hp_bar.value = enemy_sol["current_vit"]

func _add_log(message: String) -> void:
	if battle_log_label:
		battle_log_label.text += message + "\n"

func _show_message(message: String) -> void:
	if message_label:
		message_label.text = message
		message_label.visible = true
		await get_tree().create_timer(2.0).timeout
		message_label.visible = false
