## PlayerController - Handles overworld movement and interaction
extends CharacterBody2D

# Movement settings
@export var walk_speed: float = 60.0
@export var run_speed: float = 100.0
@export var tile_size: int = 16

# State
var is_moving: bool = false
var is_running: bool = false
var can_move: bool = true
var current_direction: String = "down"
var target_position: Vector2 = Vector2.ZERO
var move_progress: float = 0.0

# Interaction
var interact_radius: float = 20.0
var nearest_interactable: Node2D = null
var interaction_locked: bool = false

# Animation
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var interaction_area: Area2D = $InteractionArea

# Signals
signal player_interacted(target: Node2D)
signal player_moved(from: Vector2, to: Vector2)
signal encounter_triggered

func _ready() -> void:
	target_position = global_position
	add_to_group("player")

func _physics_process(delta: float) -> void:
	if not can_move:
		return

	if GameManager.current_state != GameManager.GameState.OVERWORLD:
		return

	if is_moving:
		_process_movement(delta)
	else:
		_handle_input()

func _handle_input() -> void:
	var direction = Vector2.ZERO

	if Input.is_action_pressed("move_up"):
		direction = Vector2.UP
		current_direction = "up"
	elif Input.is_action_pressed("move_down"):
		direction = Vector2.DOWN
		current_direction = "down"
	elif Input.is_action_pressed("move_left"):
		direction = Vector2.LEFT
		current_direction = "left"
	elif Input.is_action_pressed("move_right"):
		direction = Vector2.RIGHT
		current_direction = "right"

	is_running = Input.is_action_pressed("run")

	if direction != Vector2.ZERO:
		_start_movement(direction)

	# Check for interaction
	if Input.is_action_just_pressed("interact"):
		_try_interact()

	# Check for menu
	if Input.is_action_just_pressed("menu"):
		_open_menu()

func _start_movement(direction: Vector2) -> void:
	var new_target = global_position + direction * tile_size

	# Check collision
	if not _can_move_to(new_target):
		# Play bump animation
		_update_sprite_direction()
		if sprite:
			sprite.play("walk_" + current_direction)
			await get_tree().create_timer(0.1).timeout
			sprite.play("idle_" + current_direction)
		return

	target_position = new_target
	is_moving = true
	move_progress = 0.0

	_update_sprite_direction()
	if sprite:
		sprite.play("walk_" + current_direction)

func _process_movement(delta: float) -> void:
	var speed = run_speed if is_running else walk_speed
	var distance = target_position - global_position

	if distance.length() < 1.0:
		# Arrived at target
		global_position = target_position
		is_moving = false
		move_progress = 0.0

		if sprite:
			sprite.play("idle_" + current_direction)

		# Update position in GameManager
		var tile_pos = Vector2i(int(global_position.x / tile_size), int(global_position.y / tile_size))
		GameManager.set_player_location(
			get_tree().current_scene.name.to_lower(),
			tile_pos.x, tile_pos.y
		)

		player_moved.emit(target_position - direction() * tile_size, target_position)

		# Check for wild encounters
		_check_encounter()
		return

	# Move toward target
	var movement = distance.normalized() * speed * delta
	global_position += movement

func _can_move_to(target: Vector2) -> bool:
	"""Check if movement to target position is valid (no collisions)"""
	var space_state = get_world_2d().direct_space_state
	var query = PhysicsRayQueryParameters2D.create(global_position, target, 4)  # Layer 3 = environment
	var result = space_state.intersect_ray(query)
	return result.is_empty()

func _try_interact() -> void:
	if interaction_locked:
		return

	# Check for nearby NPCs/interactables
	var interactables = get_tree().get_nodes_in_group("interactable")
	var nearest = null
	var nearest_dist = interact_radius

	for node in interactables:
		if node is Node2D:
			var dist = global_position.distance_to(node.global_position)
			if dist < nearest_dist:
				# Check if node is in front of player
				var dir_to_node = (node.global_position - global_position).normalized()
				var player_dir = direction()
				if dir_to_node.dot(player_dir) > 0.5:
					nearest = node
					nearest_dist = dist

	if nearest:
		interaction_locked = true
		player_interacted.emit(nearest)
		if nearest.has_method("interact"):
			nearest.interact()

func _open_menu() -> void:
	can_move = false
	GameManager.change_state(GameManager.GameState.MENU)
	# Menu scene would be instantiated here

func _check_encounter() -> void:
	"""Check if player stepped on an encounter zone"""
	var encounter_areas = get_tree().get_nodes_in_group("encounter_zone")
	for area in encounter_areas:
		if area is Area2D:
			if area.get_overlapping_bodies().has(self) or _is_in_area(area):
				_trigger_encounter(area)
				return

func _is_in_area(area: Area2D) -> bool:
	if area is Area2D and area.has_node("CollisionShape2D"):
		var shape = area.get_node("CollisionShape2D") as CollisionShape2D
		if shape and shape.shape is RectangleShape2D:
			var rect_size = shape.shape.size
			var area_pos = area.global_position
			return abs(global_position.x - area_pos.x) < rect_size.x / 2 and \
				   abs(global_position.y - area_pos.y) < rect_size.y / 2
	return false

func _trigger_encounter(encounter_zone: Node) -> void:
	if not encounter_zone.has_method("get_encounter_data"):
		return

	var encounter_data = encounter_zone.get_encounter_data()
	if encounter_data.is_empty():
		return

	var encounter_chance = encounter_data.get("encounter_rate", 0.1)
	if randf() < encounter_chance:
		encounter_triggered.emit()
		can_move = false

		# Select random Solamon from zone
		var possible_solamons = encounter_data.get("solamons", [])
		if possible_solamons.is_empty():
			can_move = true
			return

		# Weighted random selection
		var total_weight = 0.0
		for entry in possible_solamons:
			total_weight += entry.get("weight", 1.0)
		var roll = randf() * total_weight
		var cumulative = 0.0
		var selected = possible_solamons[0]
		for entry in possible_solamons:
			cumulative += entry.get("weight", 1.0)
			if roll <= cumulative:
				selected = entry
				break

		var species_id = selected.get("species", "")
		var level_min = selected.get("level_min", 3)
		var level_max = selected.get("level_max", 5)
		var level = randi_range(level_min, level_max)

		# Start wild battle
		BattleManager.start_wild_encounter(species_id, level)

func _update_sprite_direction() -> void:
	if sprite:
		match current_direction:
			"up":
				sprite.flip_h = false
			"down":
				sprite.flip_h = false
			"left":
				sprite.flip_h = true
			"right":
				sprite.flip_h = false

func direction() -> Vector2:
	match current_direction:
		"up": return Vector2.UP
		"down": return Vector2.DOWN
		"left": return Vector2.LEFT
		"right": return Vector2.RIGHT
	return Vector2.DOWN

# ---- PUBLIC ----

func lock_movement() -> void:
	can_move = false

func unlock_movement() -> void:
	can_move = true
	interaction_locked = false

func teleport_to(position: Vector2) -> void:
	global_position = position
	target_position = position

func get_tile_position() -> Vector2i:
	return Vector2i(int(global_position.x / tile_size), int(global_position.y / tile_size))
