extends Node2D

export var rooms : Array

func _ready():
	for i in range(rooms.size()):
		rooms[i] = get_node("room_" + str(i+1)).global_position
