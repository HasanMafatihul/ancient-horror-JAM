extends Node2D

export var texts : Array # Text for cutscene
export var next_scene : String

var text_i : int = 0

onready var text_scene = $Control/text_scene

func _ready():
	text_scene.visible_characters = 0
	text_scene.text = texts[0]

func _input(event):
	# When ui_accept is pressed, either finish current text, or continue to next text
	if event.is_action_pressed("ui_accept"):
		if text_scene.percent_visible == 1:
			text_i += 1
			if text_i < texts.size():
				text_scene.visible_characters = 0
				text_scene.text = texts[text_i]
			else:
				# If no text after, goto next scene
				global.goto_scene(next_scene)
		else:
			text_scene.percent_visible = 1

# Character writing
func _on_Timer_timeout():
	if text_scene.percent_visible < 1:
		text_scene.visible_characters += 2
