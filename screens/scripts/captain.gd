extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var doorOpen = 0
onready var alarmActive = 0

var cd = 0.0
var door_cd = 0.0
var img = [preload("res://assets/command/door_off_alarm_of.png"), preload("res://assets/command/door_off_alarm_on.png"), 
	preload("res://assets/command/door_on_alarm_off.png"), preload("res://assets/command/door_on_alarm_on.png")]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	# Decreasing cd
	if cd > 0:
		cd -= delta
	if door_cd > 0:
		door_cd -= delta

func updateBG():
	get_node("Sprite").texture = img[doorOpen * 2 + alarmActive]

func _on_Button_pressed():
	door_func()

func _on_Button3_pressed():
	if cd <= 0:
		alarmActive ^= 1
		cd = 10.0
		var popUp = get_parent().get_parent().get_node("alarmPopUp")
		if popUp.visible:
			popUp.visible = 0
		else:
			popUp.visible = 1
		audio.playSound("alarm_button")
		updateBG()

func _on_Button2_pressed():
	door_func()

func door_func():
	if door_cd <= 0:
		door_cd = 3.0
		doorOpen ^= 1
		var strategy = "close"
		if doorOpen:
			strategy = "open"
		audio.playSound("door_button")
		get_parent().get_parent().get_node("teammate/Viewport/Node2D/TileMapDoor").changeAllDoorState(strategy)
		updateBG()
