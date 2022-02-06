extends Node2D

export var texts : Array # Text for cutscene
export var next_scene : String

var text_i : int = 0

onready var text_scene = $Control/text_scene
onready var anim = $AnimationPlayer

func _ready():
	text_scene.percent_visible = 0
	text_scene.text = texts[text_i]

func _input(event):
	# When ui_accept is pressed, either finish current text, or continue to next text
	if event.is_action_pressed("ui_accept"):
		if text_scene.percent_visible >= 1:
			text_i += 1
			if text_i < texts.size():
				var type = typeof(texts[text_i])
				print(type)
				if type == 19:
					play_Anim(texts[text_i][0])
					if texts[text_i][0] == "blackout":
						audio.stopSong()
				if type == 15:
					get_node(texts[text_i]).play()
				elif type == 4:
					text_scene.visible_characters = 0
					text_scene.text = texts[text_i]
			else:
				# If no text after, goto next scene
				global.goto_scene(next_scene)
		else:
			text_scene.percent_visible = 1

# Play animation
func play_Anim(name : String):
	get_tree().paused = true
	print(name)
	anim.play(name)

# Character writing
func _on_Timer_timeout():
	if text_scene.percent_visible < 1:
		text_scene.visible_characters += 2


func _on_AnimationPlayer_animation_finished(anim_name):
	get_tree().paused = false


func _on_crash_finished():
	audio.playSong("ost_gameplay")
