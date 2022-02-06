extends Node2D

onready var monster = $monster

func _ready():
	monster.nav_2d = $Navigation2D
	monster.target = $player
	monster.line = $Line2D
	
