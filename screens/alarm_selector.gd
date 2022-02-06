extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func closePopUp():
	var capt = get_parent().get_parent().get_parent().get_node("command/Control")
	capt.alarmActive = 0
	capt.updateBG()
	get_parent().get_parent().visible = 0


func _on_Button_pressed():
	print("button1")
	closePopUp()
	pass # Replace with function body.


func _on_Button2_pressed():
	print("button2")
	closePopUp()
	pass # Replace with function body.


func _on_Button3_pressed():
	print("button3")
	closePopUp()
	pass # Replace with function body.
