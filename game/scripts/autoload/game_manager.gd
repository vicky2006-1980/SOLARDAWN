## GameManager - Central game state and flow controller
## Handles game state, transitions, and global game logic
extends Node

# Game States
enum GameState {
	MAIN_MENU,
	OVERWORLD,
	BATTLE,
	DIALOGUE,
	MENU,
	CUTSCENE,
	PAUSED
}

# Current game state
var current_state: GameState = GameState.MAIN_MENU
var previous_state: GameState = GameState.MAIN_MENU

# Player data
var player_data: Dictionary = {
	"name": "Main Character",
	"location": {"map": "brightvale", "x": 15, "y": 25},
	"direction": "down",
	"money": 500,
	"play_time": 0.0,
	"story_flags": {},
	"badges": [],
	"achievements": []
}

# Solarlink data
var solarlink_data: Dictionary = {
	"active_team": [],  # Array of Solamon IDs (max 6)
	"stored_solamons": [],  # All owned Solamons
	"items": {},  # item_id: quantity
	"apex_crystal_installed": false,
	"apex_used_this_battle": false
}

# Relationship tracking
var relationships: Dictionary = {
	"sera": {"harmony": 0, "met": false, "dialogue_flags": {}},
	"kael": {"status": "unmet", "battles_won": 0, "dialogue_flags": {}},
	"dr_kail": {"harmony": 0, "dialogue_flags": {}},
	"mother": {"dialogue_flags": {}},
	"lily": {"dialogue_flags": {}}
}

# Story progression
var story_progress: Dictionary = {
	"current_act": 1,
	"current_beat": "intro",
	"completed_beats": [],
	"region_1_complete": false
}

# Signals
signal state_changed(new_state: GameState, old_state: GameState)
signal story_beat_completed(beat_id: String)
signal solamon_added(solamon_id: String)
signal item_added(item_id: String, quantity: int)

func _ready() -> void:
	print("[GameManager] Initialized")

func _process(delta: float) -> void:
	if current_state == GameState.OVERWORLD or current_state == GameState.MENU:
		player_data["play_time"] += delta

# State Management
func change_state(new_state: GameState) -> void:
	previous_state = current_state
	current_state = new_state
	state_changed.emit(new_state, previous_state)
	print("[GameManager] State changed: ", GameState.keys()[previous_state], " -> ", GameState.keys()[new_state])

func get_state_name() -> String:
	return GameState.keys()[current_state]

# Player Data Management
func set_player_name(new_name: String) -> void:
	player_data["name"] = new_name

func get_player_name() -> String:
	return player_data["name"]

func set_player_location(map_id: String, x: int, y: int) -> void:
	player_data["location"] = {"map": map_id, "x": x, "y": y}

func get_player_location() -> Dictionary:
	return player_data["location"]

func add_money(amount: int) -> void:
	player_data["money"] += amount

func spend_money(amount: int) -> bool:
	if player_data["money"] >= amount:
		player_data["money"] -= amount
		return true
	return false

# Story Progression
func complete_story_beat(beat_id: String) -> void:
	if beat_id not in story_progress["completed_beats"]:
		story_progress["completed_beats"].append(beat_id)
		story_progress["current_beat"] = beat_id
		story_beat_completed.emit(beat_id)
		print("[GameManager] Story beat completed: ", beat_id)

func set_story_flag(flag_id: String, value: bool = true) -> void:
	player_data["story_flags"][flag_id] = value

func get_story_flag(flag_id: String) -> bool:
	return player_data["story_flags"].get(flag_id, false)

# Solamon Management
func add_solamon(solamon_data: Dictionary) -> void:
	solarlink_data["stored_solamons"].append(solamon_data)
	if solarlink_data["active_team"].size() < 6:
		solarlink_data["active_team"].append(solamon_data["instance_id"])
	solamon_added.emit(solamon_data["species_id"])
	print("[GameManager] Solamon added: ", solamon_data["species_id"])

func get_active_team() -> Array:
	return solarlink_data["active_team"]

func get_solamon(instance_id: String) -> Dictionary:
	for solamon in solarlink_data["stored_solamons"]:
		if solamon["instance_id"] == instance_id:
			return solamon
	return {}

# Item Management
func add_item(item_id: String, quantity: int = 1) -> void:
	if solarlink_data["items"].has(item_id):
		solarlink_data["items"][item_id] += quantity
	else:
		solarlink_data["items"][item_id] = quantity
	item_added.emit(item_id, quantity)

func remove_item(item_id: String, quantity: int = 1) -> bool:
	if solarlink_data["items"].has(item_id) and solarlink_data["items"][item_id] >= quantity:
		solarlink_data["items"][item_id] -= quantity
		if solarlink_data["items"][item_id] <= 0:
			solarlink_data["items"].erase(item_id)
		return true
	return false

func has_item(item_id: String) -> bool:
	return solarlink_data["items"].has(item_id) and solarlink_data["items"][item_id] > 0

func get_item_count(item_id: String) -> int:
	return solarlink_data["items"].get(item_id, 0)

# Relationship Management
func update_relationship(character_id: String, harmony_change: int = 0) -> void:
	if relationships.has(character_id):
		if harmony_change != 0:
			var current_harmony = relationships[character_id].get("harmony", 0)
			relationships[character_id]["harmony"] = clamp(current_harmony + harmony_change, 0, 6)
		relationships[character_id]["met"] = true

func get_relationship(character_id: String) -> Dictionary:
	return relationships.get(character_id, {})

func get_harmony_level(character_id: String) -> int:
	return relationships.get(character_id, {}).get("harmony", 0)

# Utility
func generate_instance_id() -> String:
	return str(randi()) + "_" + str(Time.get_ticks_msec())

func format_play_time() -> String:
	var total_seconds = int(player_data["play_time"])
	var hours = total_seconds / 3600
	var minutes = (total_seconds % 3600) / 60
	var seconds = total_seconds % 60
	return "%02d:%02d:%02d" % [hours, minutes, seconds]
