extends KinematicBody2D

export var speed : float = 100.0 # Monster's speed measured by pixel
export var patrol_paths : Array
export var main : NodePath
export var door_tile : NodePath
export var nav_path : NodePath
export var player_path : NodePath

var rng : RandomNumberGenerator = RandomNumberGenerator.new()
var counter : float = 0

var path : PoolVector2Array # Pathing for monsters
var chase_pos : Vector2
var line : Line2D # Visually showing path
var state : String = "Idle" # Monster's current state
var path_fol : PathFollow2D
var door_counter : float = 5.0 # Door break counter

onready var rayCast2D = $RayCast2D # Monster's vision
onready var visionCone = $pivot/sprite/Light2D/Area2D
onready var sprite = $pivot/sprite
onready var interaction = $interaction
onready var door_tilemap : TileMap = get_node(door_tile)
onready var nav_2d : Navigation2D = get_node(nav_path) # Navigation2D to ascertain path
onready var target : KinematicBody2D = get_node(player_path) # Current target (player)

func _ready():
	rng.randomize()
	
	door_tilemap.changeAllDoorState("close")

func _process(_delta):
	
	# Vision / Hearing
	var collision_object = rayCast2D.get_collider()
	# set up for next frame's collision
	var direction_to_player = global_position.direction_to(target.global_position)
	rayCast2D.cast_to = direction_to_player * 1000
	if visionCone.overlaps_body(target) and collision_object == target and !get_node(main).alarm[0]:
		chase_pos = target.global_position
		state = "Chase"
		
	# Alarm state
	if get_node(main).alarm[0]:
		state = "Alert"
	elif state == "Alert":
		state = "Idle"

func _physics_process(delta):
	# State machine
	match state:
		"Idle":
			# Choose patrol path
			var dist = 1000000000
			for i in patrol_paths:
				var temp = get_node(i)
				if global_position.distance_to(temp.global_position) < dist:
					dist = global_position.distance_to(temp.global_position)
					path_fol = temp
			
			# Change state
			state = "Init_Patrol"
		"Init_Patrol":
			# Starting Patrol
			path = nav_2d.get_simple_path(global_position, path_fol.global_position, false)
			if global_position.distance_to(path_fol.global_position) < 10:
				state = "Patrol"
			# Animation
			sprite.animation = "walk"
		"Patrol":
			path = nav_2d.get_simple_path(global_position, path_fol.global_position, true)
			sprite.animation = "walk_slow"
		
		"Search":
			# Search player
			counter -= delta
			if counter <= 0:
				$pivot.rotate(deg2rad(rng.randf_range(0, 180)))
				counter = rng.randf_range(3.0, 5.0)
				if counter > 4.5:
					state = "Idle"
			sprite.animation = "idle"
	
		"Chase":
			# Chase target in last seen position
			path = nav_2d.get_simple_path(global_position, chase_pos, false)
			
			# If already reached position but does attack player
			if global_position.distance_to(chase_pos) < 10:
				state = "Search"
				counter = rng.randf_range(0.5, 2.0)
				
			sprite.animation = "walk"
		
		"Alert":
			path = nav_2d.get_simple_path(global_position, get_node(main).alarm[1], false)
			sprite.animation = "walk"
	
	#line.points = path		# Path vizualisation
	
	# Interaction
	var interact = interaction.get_overlapping_bodies()
	for i in interact:
		# Break door
		if i == door_tilemap:
			door_counter -= delta
			if door_counter <= 0.0:
				door_counter = 0
				door_tilemap.breakDoor(global_position)
		elif i == target:
			print("You died!!")
	
	# Move
	var move_distance = speed * delta
	move_along_path(move_distance)
	#move_and_slide(Vector2(0.0, 0.0))

# Movement code following path
func move_along_path(distance : float):
	var start_point = position
	for _i in range(path.size()):
		var distance_to_next = start_point.distance_to(path[0])
		if distance <= distance_to_next and distance >= 0.0:
			position = start_point.linear_interpolate(path[0], distance / distance_to_next)
			$pivot.rotation = get_angle_to(path[0])
			var _collision = move_and_slide(Vector2(0,0))
			
			break
		distance -= distance_to_next
		
		start_point = path[0]
		path.remove(0)
