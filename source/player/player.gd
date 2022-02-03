extends KinematicBody2D

export var speed = 150

var velocity:Vector2

#TEMP
signal change_door

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
	
	# Open/close door
	if Input.is_action_just_pressed("ui_accept"):
		emit_signal("change_door")
	
	# Animation
	
		
	# Movement
	velocity = move_and_slide(velocity)
