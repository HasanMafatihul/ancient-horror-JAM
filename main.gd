extends Node2D

onready var nav_2d = $Navigation2D
onready var monster = $monster
onready var player = $player
onready var line2d = $Line2D

func _ready():
	monster.nav_2d = nav_2d
	monster.target = player
	monster.line = line2d

func _unhandled_input(event):
	if not event is InputEventMouseButton:
		return
	
