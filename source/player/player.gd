extends KinematicBody2D

export var speed = 150

onready var interact_area = $interact

var velocity : Vector2
var interact : Array

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

func _process(_delta):
	# Interaction with objects
	interact = interact_area.get_overlapping_areas()
	if Input.is_action_pressed("interact"):
		for i in interact:
			if i.is_in_group("interact"):
				i.interact()

# Move per physic process (see godot documentation)
func _physics_process(_delta):
	velocity = get_input()
	
	# Open/close door
	if Input.is_action_just_pressed("ui_accept"):
		emit_signal("change_door")
	
	# Animation
	
		
	# Movement
	velocity = move_and_slide(velocity)
