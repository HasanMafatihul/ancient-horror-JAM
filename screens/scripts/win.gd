extends Node2D

func _ready():
	audio.playSong("ost_gameover")
	$AnimationPlayer.play("win")
