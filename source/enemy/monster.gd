extends KinematicBody2D

export var speed : float = 100.0 # Monster's speed measured by pixel
export var patrol_paths : Array

var rng : RandomNumberGenerator = RandomNumberGenerator.new()
var counter : float = 0

var path : PoolVector2Array # Pathing for monsters
var nav_2d : Navigation2D # Navigation2D to ascertain path
var target # Current target
var chase_pos : Vector2
var line : Line2D # Visually showing path
var state : String = "Idle" # Monster's current state
var path_fol : PathFollow2D

onready var rayCast2D = $RayCast2D # Monster's vision
onready var visionCone = $sprite/Light2D/Area2D

func _ready():
	rng.randomize()

func _process(delta):
	
	# Vision / Hearing
	var collision_object = rayCast2D.get_collider()
	# set up for next frame's collision
	var direction_to_player = global_position.direction_to(target.global_position)
	rayCast2D.cast_to = direction_to_player * 1000
	if visionCone.overlaps_body(target) and collision_object == target:
		chase_pos = target.global_position
		state = "Chase"

func _physics_process(delta):
	# State machine
	if state == "Idle":
		# Choose patrol path
		var dist = 1000
		for i in patrol_paths:
			var temp = get_node(i)
			if global_position.distance_to(temp.global_position) < dist:
				dist = global_position.distance_to(temp.global_position)
				path_fol = temp
		
		# Change state
		state = "Init_Patrol"
	
	elif state == "Init_Patrol":
		# Starting Patrol
		path = nav_2d.get_simple_path(global_position, path_fol.global_position, false)
		if global_position.distance_to(path_fol.global_position) < 10:
			state = "Patrol"
	
	elif state == "Patrol":
		path = nav_2d.get_simple_path(global_position, path_fol.global_position, true)
	
	elif state == "Search":
		# Search player
		counter -= delta
		if counter <= 0:
			$sprite.rotate(deg2rad(rng.randf_range(0, 180)))
			counter = rng.randf_range(3.0, 5.0)
			if counter > 4.5:
				state = "Idle"
	
	elif state == "Chase":
		# Chase target in last seen position
		path = nav_2d.get_simple_path(global_position, chase_pos, true)
		if global_position.distance_to(chase_pos) < 10:
			state = "Search"
			counter = rng.randf_range(0.5, 2.0)
		
	
	line.points = path
	# Move
	var move_distance = speed * delta
	move_along_path(move_distance)
	#move_and_slide(Vector2(0.0, 0.0))

# Movement code following path
func move_along_path(distance : float):
	var start_point = position
	for i in range(path.size()):
		var distance_to_next = start_point.distance_to(path[0])
		if distance <= distance_to_next and distance >= 0.0:
			position = start_point.linear_interpolate(path[0], distance / distance_to_next)
			$sprite.rotation = get_angle_to(path[0])
			move_and_slide(Vector2(0,0))
			break
		distance -= distance_to_next
		
		start_point = path[0]
		path.remove(0)
