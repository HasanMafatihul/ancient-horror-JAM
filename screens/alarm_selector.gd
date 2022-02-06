extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var main_teammate_path : NodePath
onready var main_teammate = get_node(main_teammate_path)

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
	main_teammate.alarm(0)
	closePopUp()

func _on_Button2_pressed():
	print("button2")
	main_teammate.alarm(1)
	closePopUp()

func _on_Button3_pressed():
	print("button3")
	main_teammate.alarm(2)
	closePopUp()
