extends Node2D

func _ready():
	audio.playSound("death")
	audio.playSong("ost_gameover")
	$AnimationPlayer.play("death")
