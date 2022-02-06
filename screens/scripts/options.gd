extends Control

func _ready():
	# Synchronizing
	$VBoxContainer/master.value = audio.volume_master
	$VBoxContainer/sound.value = audio.volume_sfx

func _process(delta):
	# Constantly adjusting
	audio.volume_master = $VBoxContainer/master.value
	audio.volume_sfx = $VBoxContainer/sound.value
