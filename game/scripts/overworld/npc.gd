## NPC - Non-Player Character with dialogue and interaction
extends Node2D

@export var npc_id: String = ""
@export var npc_name: String = "NPC"
@export var dialogue_id: String = ""
@export var sprite_texture: Texture2D
@export var facing_direction: String = "down"
@export var can_move: bool = false
@export var walk_range: int = 2  # tiles
@export var walk_speed: float = 30.0

# State
var is_interacting: bool = false
var move_timer: float = 0.0
var start_position: Vector2 = Vector2.ZERO
var target_position: Vector2 = Vector2.ZERO
var is_walking: bool = false

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var interaction_area: Area2D = $InteractionArea

# NPC appearance indicator (exclamation mark / interaction icon)
@onready var interact_icon: Sprite2D = $InteractIcon

func _ready() -> void:
	add_to_group("interactable")
	add_to_group("npc")
	start_position = global_position
	target_position = global_position

	if interact_icon:
		interact_icon.visible = false

func _process(delta: float) -> void:
	if is_interacting:
		return

	if can_move:
		_process_npc_movement(delta)

func _process_npc_movement(delta: float) -> void:
	if is_walking:
		var direction = (target_position - global_position).normalized()
		global_position += direction * walk_speed * delta
		if global_position.distance_to(target_position) < 1.0:
			global_position = target_position
			is_walking = false
			if sprite:
				sprite.play("idle_" + facing_direction)
	else:
		move_timer += delta
		if move_timer > randf_range(2.0, 5.0):
			move_timer = 0.0
			_choose_new_position()

func _choose_new_position() -> void:
	var directions = [Vector2.UP, Vector2.DOWN, Vector2.LEFT, Vector2.RIGHT]
	var dir = directions[randi() % directions.size()]
	var new_target = start_position + dir * 16 * randi_range(1, walk_range)

	# Keep within range
	if new_target.distance_to(start_position) > walk_range * 16:
		return

	target_position = new_target
	is_walking = true

	# Update facing direction
	if dir == Vector2.UP: facing_direction = "up"
	elif dir == Vector2.DOWN: facing_direction = "down"
	elif dir == Vector2.LEFT: facing_direction = "left"
	elif dir == Vector2.RIGHT: facing_direction = "right"

	if sprite:
		sprite.play("walk_" + facing_direction)

func interact() -> void:
	"""Called when player interacts with this NPC"""
	is_interacting = true

	# Face the player
	_face_player()

	# Show interact icon briefly
	if interact_icon:
		interact_icon.visible = false

	# Start dialogue
	if dialogue_id != "":
		DialogueManager.start_dialogue_from_id(dialogue_id)

		# Wait for dialogue to finish
		await DialogueManager.dialogue_ended
		is_interacting = false
	else:
		# Default dialogue
		_show_default_dialogue()
		is_interacting = false

func _face_player() -> void:
	var player = get_tree().get_first_node_in_group("player")
	if player == null:
		return

	var dir = (player.global_position - global_position).normalized()
	if abs(dir.x) > abs(dir.y):
		facing_direction = "right" if dir.x > 0 else "left"
	else:
		facing_direction = "down" if dir.y > 0 else "up"

	if sprite:
		sprite.play("idle_" + facing_direction)

func _show_default_dialogue() -> void:
	var default_dialogue = {
		"id": "default_npc",
		"start_node": "node_0",
		"nodes": {
			"node_0": {
				"speaker": npc_name,
				"text": "Hello there! Beautiful day, isn't it?",
				"next": ""
			}
		}
	}
	DialogueManager.start_dialogue(default_dialogue)

# ---- SIGNAL HANDLERS ----

func _on_interaction_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		if interact_icon:
			interact_icon.visible = true

func _on_interaction_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		if interact_icon:
			interact_icon.visible = false

# ---- PUBLIC ----

func set_dialogue(new_dialogue_id: String) -> void:
	dialogue_id = new_dialogue_id

func set_appearance(texture: Texture2D) -> void:
	sprite_texture = texture
	if sprite:
		sprite.texture = texture

func change_facing(dir: String) -> void:
	facing_direction = dir
	if sprite:
		sprite.play("idle_" + facing_direction)
