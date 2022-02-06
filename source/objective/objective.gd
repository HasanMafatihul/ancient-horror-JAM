extends Area2D

# Player init
export var player_node : NodePath
onready var player : KinematicBody2D = get_node(player_node)



func _on_Area2D_body_entered(body):
	if body == player:
		print("You win!")
