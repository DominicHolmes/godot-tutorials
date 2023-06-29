extends Area2D

signal hit

# How fast the player will move (p/s)
@export var speed = 400

# Size of the game window
var screen_size

# On mount
func _ready():
	screen_size = get_viewport_rect().size
	hide()

# On frame
func _process(delta):
	# Players movement vector
	var velocity = Vector2.ZERO
	
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
		
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
		
	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
	
	if velocity.x != 0:
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_v = false
		$AnimatedSprite2D.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$AnimatedSprite2D.animation = "up"
		$AnimatedSprite2D.flip_v = velocity.y > 0

# On start
func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false

# On hit
func _on_body_entered(body):
	hide()
	hit.emit()
	# Must be defferred b.c. we can't change physics props on a physics callback
	$CollisionShape2D.set_deferred("disabled", true)
