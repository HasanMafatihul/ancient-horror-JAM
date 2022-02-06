extends Node2D

onready var monster = $monster
var alarm : Array = [false, Vector2(0,0), 0] # [IsAlarmOn, AlarmLocation in Vector2, AlarmTimer]

func _ready():
	monster.nav_2d = $Navigation2D
	monster.target = $player
	monster.line = $Line2D

func _process(delta):
	# Alarm timer countdown
	if alarm[2] > 0:
		alarm[2] -= delta
	if alarm[2] <= 0:
		alarm[0] = false

func alarm(pos):
	alarm = [true, pos, 5]
