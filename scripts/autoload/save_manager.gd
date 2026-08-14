## SaveManager - Handles game save/load functionality
extends Node

const SAVE_PATH = "user://savegame.json"
const SAVE_VERSION = 1

signal save_completed(success: bool)
signal load_completed(success: bool)

func _ready() -> void:
	print("[SaveManager] Initialized")

# ---- SAVE ----

func save_game() -> bool:
	var save_data = {
		"version": SAVE_VERSION,
		"timestamp": Time.get_datetime_string_from_system(),
		"player": {
			"name": GameManager.player_data["name"],
			"location": GameManager.player_data["location"],
			"direction": GameManager.player_data["direction"],
			"money": GameManager.player_data["money"],
			"play_time": GameManager.player_data["play_time"],
			"story_flags": GameManager.player_data["story_flags"],
			"badges": GameManager.player_data["badges"]
		},
		"solarlink": {
			"active_team": GameManager.solarlink_data["active_team"],
			"stored_solamons": GameManager.solarlink_data["stored_solamons"],
			"items": GameManager.solarlink_data["items"],
			"apex_crystal_installed": GameManager.solarlink_data["apex_crystal_installed"]
		},
		"story": {
			"current_act": GameManager.story_progress["current_act"],
			"current_beat": GameManager.story_progress["current_beat"],
			"completed_beats": GameManager.story_progress["completed_beats"]
		},
		"relationships": GameManager.relationships.duplicate(true),
		"world": {
			"map_states": {},
			"collectibles": []
		}
	}

	var json_string = JSON.stringify(save_data, "  ")
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if file:
		file.store_string(json_string)
		file.close()
		save_completed.emit(true)
		print("[SaveManager] Game saved successfully")
		return true
	else:
		save_completed.emit(false)
		push_error("[SaveManager] Failed to open save file for writing")
		return false

# ---- LOAD ----

func load_game() -> bool:
	if not FileAccess.file_exists(SAVE_PATH):
		print("[SaveManager] No save file found")
		load_completed.emit(false)
		return false

	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	if not file:
		push_error("[SaveManager] Failed to open save file for reading")
		load_completed.emit(false)
		return false

	var json_string = file.get_as_text()
	file.close()

	var json = JSON.new()
	var error = json.parse(json_string)
	if error != OK:
		push_error("[SaveManager] Failed to parse save file: " + json.get_error_message())
		load_completed.emit(false)
		return false

	var save_data = json.data
	if save_data.get("version", 0) != SAVE_VERSION:
		push_warning("[SaveManager] Save version mismatch. May need migration.")

	# Restore player data
	GameManager.player_data["name"] = save_data["player"]["name"]
	GameManager.player_data["location"] = save_data["player"]["location"]
	GameManager.player_data["direction"] = save_data["player"]["direction"]
	GameManager.player_data["money"] = save_data["player"]["money"]
	GameManager.player_data["play_time"] = save_data["player"]["play_time"]
	GameManager.player_data["story_flags"] = save_data["player"]["story_flags"]
	GameManager.player_data["badges"] = save_data["player"]["badges"]

	# Restore Solarlink data
	GameManager.solarlink_data["active_team"] = save_data["solarlink"]["active_team"]
	GameManager.solarlink_data["stored_solamons"] = save_data["solarlink"]["stored_solamons"]
	GameManager.solarlink_data["items"] = save_data["solarlink"]["items"]
	GameManager.solarlink_data["apex_crystal_installed"] = save_data["solarlink"]["apex_crystal_installed"]

	# Restore story progress
	GameManager.story_progress["current_act"] = save_data["story"]["current_act"]
	GameManager.story_progress["current_beat"] = save_data["story"]["current_beat"]
	GameManager.story_progress["completed_beats"] = save_data["story"]["completed_beats"]

	# Restore relationships
	GameManager.relationships = save_data["relationships"]

	load_completed.emit(true)
	print("[SaveManager] Game loaded successfully")
	return true

# ---- UTILITY ----

func has_save() -> bool:
	return FileAccess.file_exists(SAVE_PATH)

func delete_save() -> bool:
	if FileAccess.file_exists(SAVE_PATH):
		DirAccess.remove_absolute(SAVE_PATH)
		print("[SaveManager] Save file deleted")
		return true
	return false

func get_save_info() -> Dictionary:
	"""Get basic info about the save file without fully loading it"""
	if not has_save():
		return {}

	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	if not file:
		return {}

	var json_string = file.get_as_text()
	file.close()

	var json = JSON.new()
	if json.parse(json_string) != OK:
		return {}

	var data = json.data
	return {
		"name": data.get("player", {}).get("name", "Unknown"),
		"play_time": data.get("player", {}).get("play_time", 0),
		"timestamp": data.get("timestamp", "Unknown"),
		"location": data.get("player", {}).get("location", {}).get("map", "Unknown"),
		"act": data.get("story", {}).get("current_act", 1),
		"beat": data.get("story", {}).get("current_beat", "Unknown")
	}

func quick_save() -> void:
	"""Auto-save trigger"""
	save_game()

func export_save() -> String:
	"""Export save data as JSON string (for debugging)"""
	if not FileAccess.file_exists(SAVE_PATH):
		return ""
	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	var content = file.get_as_text()
	file.close()
	return content
