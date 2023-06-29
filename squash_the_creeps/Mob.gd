extends CharacterBody3D

# min speed of mob m/s
@export var min_speed = 10

# max speed of mob m/s
@export var max_speed = 18

func _physics_process(delta):
	move_and_slide()

# Called from Main scene
func initialize(start_position, player_position):
	#  Position mob by placing at start pos and rotate it toward player pos
	look_at_from_position(start_position, player_position, Vector3.UP)
	# Rotate it randomly within -90 to 90 deg, so it doesn't move directly
	# toward player
	rotate_y(randf_range(-PI / 4, PI / 4))
	
	# Get a random speed (int)
	var random_speed = randi_range(min_speed, max_speed)
	# Forward velocity
	velocity = Vector3.FORWARD * random_speed
	# Rotate velocity vector to match mob's Y rotation
	# to move in direction mob is facing
	velocity = velocity.rotated(Vector3.UP, rotation.y)

func _on_visible_on_screen_notifier_3d_screen_exited():
	queue_free()
