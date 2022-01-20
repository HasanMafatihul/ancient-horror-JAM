extends Sprite

var speed = 100.0
var path :PoolVector2Array
var nav_2d : Navigation2D
var target
var line : Line2D

func _physics_process(delta):
	path = nav_2d.get_simple_path(global_position, target.global_position)
	line.points = path
	
	#Move
	var move_distance = speed * delta
	move_along_path(move_distance)
	
func move_along_path(distance : float):
	var start_point = position
	for i in range(path.size()):
		var distance_to_next = start_point.distance_to(path[0])
		if distance <= distance_to_next and distance >= 0.0:
			position = start_point.linear_interpolate(path[0], distance / distance_to_next)
			break
		distance -= distance_to_next
		start_point = path[0]
		path.remove(0)
