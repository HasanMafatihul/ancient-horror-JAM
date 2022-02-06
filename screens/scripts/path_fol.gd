extends PathFollow2D

# Patrolling speed (Unknown unit)
export var speed : float = 100

func _physics_process(_delta):
	offset += speed * _delta
