extends KinematicBody2D

var speed = 100.0 # Monster's speed measured by pixel
var path : PoolVector2Array # Pathing for monsters
var nav_2d : Navigation2D # Navigation2D to ascertain path
var target # Current target
var line : Line2D # Visually showing path
var state : String = "Idle" # Monster's current state
var rooms_parent : Node2D
var rooms : Array

onready var rayCast2D = $RayCast2D # Monster's vision

func _physics_process(delta):
	# Setting up rooms location
	if rooms.size() == 0:
		rooms = rooms_parent.rooms
		print(rooms)
	
	# Vision / Hearing
	var collision_object = rayCast2D.get_collider()
	# set up for next frame's collision
	var direction_to_player = global_position.direction_to(target.global_position)
	rayCast2D.cast_to = direction_to_player * 500
	
	# State machine
	if state == "Idle":
		# Patrolling rooms
		# Choose room to patrol (WIP) (DEPRECATED)
		var patrol_dis = 1000
		var patrol_pos = global_position
		for i in rooms:
			print(global_position.distance_to(i))
			if global_position.distance_to(i) < patrol_dis and global_position.distance_to(i) > 50:
				patrol_dis = global_position.distance_to(i)
				patrol_pos = i
		
		# Set path
		path = []
		for i in range(rooms.size()):
			if i == 0:
				path.append_array(nav_2d.get_simple_path(global_position, rooms[i], false))
			else:
				path.append_array(nav_2d.get_simple_path(rooms[i-1], rooms[i], false))
		line.points = path
		state = "Patrol"
	elif state == "Chase":
		# Chase target
		path = nav_2d.get_simple_path(global_position, target.global_position, false)
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
			break
		distance -= distance_to_next
		
		start_point = path[0]
		path.remove(0)
