extends KinematicBody2D

export var speed = 150

onready var interact_area = $interact

var velocity : Vector2
var interact : Array

onready var footstep = $sound/footstep

# Input
func get_input():
	var movement = Vector2()
	if Input.is_action_pressed("up"):
		movement.y -= speed
		rotation_degrees = 0
	if Input.is_action_pressed("down"):
		movement.y += speed
		rotation_degrees = 180
	if Input.is_action_pressed("left"):
		movement.x -= speed
		rotation_degrees = 270
	if Input.is_action_pressed("right"):
		movement.x += speed
		rotation_degrees = 90
	return movement

func _ready():
	footstep.play()

func _process(_delta):
	# Interaction with objects
	$inter_sprite.visible = false
	$inter_sprite.set_rotation(-rotation)
	interact = interact_area.get_overlapping_areas()
	for i in interact:
		if i.is_in_group("interact"):
			if Input.is_action_just_pressed("interact"):
				i.interact()
				$sound/interact.play()
			$inter_sprite.visible = true

# Move per physic process (see godot documentation)
func _physics_process(_delta):
	velocity = get_input()
	
	# Animation
	if velocity == Vector2(0, 0):
		$sprite.animation = "idle"
		footstep.stream_paused = true
	else:
		$sprite.animation = "walk"
		footstep.stream_paused = false
		
	# Movement
	velocity = move_and_slide(velocity)
