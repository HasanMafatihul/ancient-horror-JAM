extends Node

onready var ost = $ost
var turned = true
var volume_master = 100
var volume_sfx = 100

var songDict = {
	"ost_default": "res://audio/ost/menu-stage_mungkin.mp3",
}

# How to add sound:
#	+ Add "AudioStream" node under audiocontrol. Name it appropriately. Child it to
#	  other node as needed
#	+ Add the corresponding AudioStream node with it's name in soundDict (example below)

var soundDict = {
	"shoot" : "player/shoot",
}

# Setting the volume every process
func _process(_delta):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), linear2db(volume_master/100))
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("sfx"), linear2db(volume_master/100))

# Play song using ost audiostream
func playSong(song: String, pos: float = 0.0):
	if turned:
		ost.stream.resource_path = songDict[song]
		ost.play()
		ost.seek(pos)

# Get current ost's current time
func getSongTime() -> float:
	return ost.get_playback_position()

# Play sound using respective audiostream
func playSound(sound:String):
	get_node(soundDict[sound]).play()

# Stop all sound
func stopAll():
	ost.stop()
	for i in soundDict.keys():
		get_node(soundDict[i]).stop()
