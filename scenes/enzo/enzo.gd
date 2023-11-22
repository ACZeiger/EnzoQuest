extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -200.0
const ENZO_SCALE = 0.085

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var movement_mode = "stand"


func _physics_process(delta) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	if Input.is_action_pressed("jump") and velocity.y < 0:
		if velocity.y > -1800.0:
			velocity.y += JUMP_VELOCITY / 2
		else:
			velocity.y = delta
	if (Input.is_action_just_released("jump") and velocity.y < 0) or velocity.y == 0:
		velocity.y = delta
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		if direction > 0:
			$AnimatedSprite2D.scale.x = ENZO_SCALE
			$CollisionPolygon2D.scale.x = 1
		if direction < 0:
			$AnimatedSprite2D.scale.x = -1 * ENZO_SCALE
			$CollisionPolygon2D.scale.x = -1
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
