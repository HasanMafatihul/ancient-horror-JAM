extends Node

onready var ost = $ost
var turned = true
var volume_master = 100
var volume_sfx = 100
var current_song = ""

var songDict = {
	"ost_menu": "res://assets/sounds/default but happy for menus.wav",
	"ost_gameplay": "res://assets/sounds/defaultbgm with space ambience.wav",
	"ost_chase": "res://assets/sounds/chase bgm plusdrum.wav",
	"ost_gameover": "res://assets/sounds/gameover bgm.wav",
}

# How to add sound:
#	+ Add "AudioStream" node under audiocontrol. Name it appropriately. Child it to
#	  other node as needed
#	+ Add the corresponding AudioStream node with it's name in soundDict (example below)

var soundDict = {
	"shoot" : "player/shoot",
	"ui_click" : "ui/click",
	"alarm_button": "ui/alarm_button",
	"door_button": "ui/door_button",
	"death": "ui/death",
	"ui_text": "ui/text",
}

# Setting the volume every process
func _process(_delta):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), linear2db(volume_master/100))
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("sfx"), linear2db(volume_master/100))

# Play song using ost audiostream
func playSong(song: String, pos: float = 0.0):
	if turned:
		ost.stream = load(songDict[song])
		ost.play(pos)
		print(ost.stream.resource_path)
		current_song = song

# Get current ost's current time
func getSongTime() -> float:
	return ost.get_playback_position()

func getSong() -> String:
	return current_song

# Play sound using respective audiostream
func playSound(sound:String):
	get_node(soundDict[sound]).play()

# Stop all sound
func stopAll():
	ost.stop()
	for i in soundDict.keys():
		get_node(soundDict[i]).stop()

# Stop song
func stopSong():
	ost.stop()
