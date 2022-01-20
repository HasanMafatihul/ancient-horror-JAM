extends KinematicBody2D

var speed = 500

var velocity:Vector2

# Input
func get_input():
	var movement = Vector2()
	if Input.is_action_pressed("up"):
		movement.y -= speed
	if Input.is_action_pressed("down"):
		movement.y += speed
	if Input.is_action_pressed("left"):
		movement.x -= speed
	if Input.is_action_pressed("right"):
		movement.x += speed
	return movement

# Move per physic process (see godot documentation)
func _physics_process(delta):
	velocity = get_input()
	
	# Animation
	
		
	# Movement
	velocity = move_and_slide(velocity)
