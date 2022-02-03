extends PathFollow2D

# Patrolling speed (Unknown unit)
export var speed : float = 0.75

func _physics_process(delta):
	offset += speed
