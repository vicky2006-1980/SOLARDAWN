extends AnimatedSprite2D

@export var speed_fps: float = 8.0

func _ready() -> void:
	_setup_animations()
	animation = &"walk_down"
	stop()


func _setup_animations() -> void:
	var sprite_sheet := sprite_frames

	if sprite_sheet == null:
		push_error("Player AnimatedSprite2D has no SpriteFrames resource.")
		return

	sprite_sheet.set_animation_speed(&"walk_down", speed_fps)
	sprite_sheet.set_animation_loop(&"walk_down", true)

	sprite_sheet.set_animation_speed(&"walk_up", speed_fps)
	sprite_sheet.set_animation_loop(&"walk_up", true)

	sprite_sheet.set_animation_speed(&"walk_left", speed_fps)
	sprite_sheet.set_animation_loop(&"walk_left", true)

	sprite_sheet.set_animation_speed(&"walk_right", speed_fps)
	sprite_sheet.set_animation_loop(&"walk_right", true)


func set_direction(direction: Vector2) -> void:
	if direction == Vector2.ZERO:
		stop()
		return

	if abs(direction.x) > abs(direction.y):
		if direction.x > 0:
			animation = &"walk_right"
		else:
			animation = &"walk_left"
	else:
		if direction.y > 0:
			animation = &"walk_down"
		else:
			animation = &"walk_up"

	play()
