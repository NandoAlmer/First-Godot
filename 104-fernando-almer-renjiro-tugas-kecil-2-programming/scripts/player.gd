extends CharacterBody2D

var max_speed = 200
var jump_force = -400.0
var last_direction := Vector2(1, 0)

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta

	# Ubah "ui_accept" menjadi "move_up"
	if Input.is_action_just_pressed("move_up") and is_on_floor():
		velocity.y = jump_force

	var move_x = Input.get_axis("move_left", "move_right")
	velocity.x = move_x * max_speed

	# Update last_direction baik di tanah maupun di udara
	if move_x != 0:
		last_direction = Vector2(move_x, 0)

	move_and_slide()
	update_animation(move_x)

func update_animation(move_x: float) -> void:
	if not is_on_floor():
		# Mengecek arah dari move_x langsung atau last_direction
		if move_x < 0 or (move_x == 0 and last_direction.x < 0):
			$AnimatedSprite2D.play("jump_left")
		else:
			$AnimatedSprite2D.play("jump_right")
	else:
		if move_x != 0:
			play_walk_animation(move_x)
		else:
			play_idle_animation(last_direction)

func play_walk_animation(move_x: float) -> void:
	if move_x > 0:
		$AnimatedSprite2D.play("walk_right")
	elif move_x < 0:
		$AnimatedSprite2D.play("walk_left")

func play_idle_animation(direction: Vector2) -> void:
	if direction.x < 0:
		$AnimatedSprite2D.play("idle_left")
	else:
		$AnimatedSprite2D.play("idle_right")
