## MapScene - Base script for overworld map scenes
extends Node2D

@export var map_id: String = ""
@export var map_name: String = ""
@export var default_music: String = ""
@export var camera_limits: Rect2 = Rect2(0, 0, 480, 270)

# Map transitions
@export var transitions: Array = []  # Array of {position: Vector2, target_map: String, target_pos: Vector2}

@onready var player: CharacterBody2D = $Player
@onready var camera: Camera2D = $Player/Camera2D
@onready var transition_layer: CanvasLayer = $TransitionLayer

func _ready() -> void:
	# Setup camera limits
	if camera:
		camera.limit_left = int(camera_limits.position.x)
		camera.limit_top = int(camera_limits.position.y)
		camera.limit_right = int(camera_limits.position.x + camera_limits.size.x)
		camera.limit_bottom = int(camera_limits.position.y + camera_limits.size.y)

	# Position player at saved location or default
	var player_loc = GameManager.get_player_location()
	if player_loc["map"] == map_id:
		if player:
			player.teleport_to(Vector2(player_loc["x"] * 16, player_loc["y"] * 16))

	# Play map music
	if default_music != "":
		AudioManager.play_music(default_music)
	elif AudioManager.get_map_music(map_id) != "":
		AudioManager.play_music(AudioManager.get_map_music(map_id))

	# Connect signals
	if player:
		player.player_interacted.connect(_on_player_interacted)

	GameManager.change_state(GameManager.GameState.OVERWORLD)

func _on_player_interacted(target: Node2D) -> void:
	"""Handle interaction with NPCs, signs, objects"""
	if target.has_method("interact"):
		target.interact()

func _process(delta: float) -> void:
	_check_map_transitions()

func _check_map_transitions() -> void:
	"""Check if player reached a map transition point"""
	if player == null:
		return
	var player_pos = player.global_position

	for transition in transitions:
		var t_pos = transition["position"]
		if player_pos.distance_to(t_pos) < 12.0:
			_transition_to_map(transition["target_map"], transition["target_pos"])
			return

func _transition_to_map(target_map: String, target_pos: Vector2) -> void:
	"""Transition to another map"""
	if player:
		player.lock_movement()

	# Fade out
	_fade_to_black()
	await get_tree().create_timer(0.3).timeout

	# Update game state
	GameManager.set_player_location(target_map, int(target_pos.x / 16), int(target_pos.y / 16))

	# Load new scene
	var scene_path = "res://scenes/overworld/maps/" + target_map + ".tscn"
	if ResourceLoader.exists(scene_path):
		get_tree().change_scene_to_file(scene_path)
	else:
		push_warning("[MapScene] Map not found: " + scene_path)
		if player:
			player.unlock_movement()

func _fade_to_black() -> void:
	if transition_layer:
		var overlay = ColorRect.new()
		overlay.color = Color(0, 0, 0, 0)
		overlay.set_anchors_preset(Control.PRESET_FULL_RECT)
		transition_layer.add_child(overlay)
		var tween = create_tween()
		tween.tween_property(overlay, "color", Color(0, 0, 0, 1), 0.3)

# ---- MAP EVENT TRIGGERS ----

func trigger_story_event(event_id: String) -> void:
	"""Trigger a story event on this map"""
	match event_id:
		"starter_selection":
			DialogueManager.start_dialogue_from_id("starter_selection")
		"opening_morning":
			DialogueManager.start_dialogue_from_id("opening_morning")
		"meeting_kail":
			DialogueManager.start_dialogue_from_id("meeting_kail")

func heal_all_solamons() -> void:
	"""Heal all player Solamons (for healing center)"""
	for sol in GameManager.solarlink_data["stored_solamons"]:
		sol["current_vit"] = sol["stats"]["vitality"]
		sol["status_conditions"] = []
