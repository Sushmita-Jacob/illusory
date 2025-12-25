extends CharacterBody2D


const SPEED = 1000.0
const JUMP_VELOCITY = -700.0

var can_double_jump = true

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		can_double_jump = true
		velocity.y = JUMP_VELOCITY
	# Handle double jump.
	elif Input.is_action_just_pressed("ui_accept") and !is_on_floor() and can_double_jump:
		can_double_jump = false
		velocity.y = JUMP_VELOCITY
		
	# Handles respawn.
	if global_position.y > 2000:
		get_tree().reload_current_scene()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	move_and_slide()
