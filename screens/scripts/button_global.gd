extends Button

export var path : String
export var altkey : String

func _pressed():
	global.goto_scene(path)
	audio.playSound("ui_click")

func _input(event):
	if altkey:
		if event.is_action_pressed(altkey):
			global.goto_scene(path)
