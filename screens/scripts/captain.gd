extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var doorOpen = 0
onready var alarmActive = 0
var img = [preload("res://assets/command/door_off_alarm_of.png"), preload("res://assets/command/door_off_alarm_on.png"), 
	preload("res://assets/command/door_on_alarm_off.png"), preload("res://assets/command/door_on_alarm_on.png")]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func updateBG():
	get_node("Sprite").texture = img[doorOpen * 2 + alarmActive]

func _on_Button_pressed():
	doorOpen ^= 1
	var strategy = "close"
	if doorOpen:
		strategy = "open"
	get_parent().get_parent().get_node("teammate/Viewport/Node2D/TileMapDoor").changeAllDoorState(strategy)
	updateBG()

func _on_Button3_pressed():
	alarmActive ^= 1
	var popUp = get_parent().get_parent().get_node("alarmPopUp")
	if popUp.visible:
		popUp.visible = 0
	else:
		popUp.visible = 1
	updateBG()


func _on_Button2_pressed():
	pass # Replace with function body.
