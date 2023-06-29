extends CharacterBody3D

# Player speed in m/s
@export var speed = 14

# Downward acceleration when airborne, in m/s
@export var fall_acceleration = 75

# Vert. impulse applied to player on jump, in m/s
@export var jump_impulse = 40

var target_velocity = Vector3.ZERO

# Like process, updates node every physics frame
# Specifically designed for physics-related code like moving a character body
func _physics_process(delta):
	# Local var for input direction
	var direction = Vector3.ZERO
	# Check move inputs
	if Input.is_action_pressed("move_right"):
		direction.x += 1
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
	if Input.is_action_pressed("move_back"):
		direction.z += 1
	if Input.is_action_pressed("move_forward"):
		direction.z -= 1
	
	if direction != Vector3.ZERO:
		# normalize vector so that diagonal speed remains 1
		direction = direction.normalized()
		# rotate character pivot to face in direction of movement
		$Pivot.look_at(position + direction, Vector3.UP)
	
	# Ground velocity
	target_velocity.x = direction.x * speed
	target_velocity.z = direction.z * speed
	
	# Vertical velocity
	if not is_on_floor():
		# If in the air, fall to the floor
		target_velocity.y = target_velocity.y - (fall_acceleration * delta)
	
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		target_velocity.y = jump_impulse
	
	# Move character by setting velocity + letting move_and_slide take it away
	velocity = target_velocity
	move_and_slide()
