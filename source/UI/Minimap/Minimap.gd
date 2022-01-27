extends Node2D


func _ready():
	updatePosition()
	zoom(getzoom())

func updatePosition():
	get_node("PlayerIcon").position = get_parent().get_parent().get_parent().get_node("teammate/Viewport/main/player").position / 5
	get_node("EnemyIcon").position = get_parent().get_parent().get_parent().get_node("teammate/Viewport/main/monster").position / 5

func _process(delta):
	updatePosition()
	
func zoom(x):
	x = max(x , 0.2)
	x = min(x , 2.5)
	get_node("PlayerIcon/Camera2D").zoom = Vector2(x,x)
	for i in get_children():
		if i.is_in_group("Icon"):
			if i.name == "PlayerIcon":
				i.scale = Vector2(0.8*sqrt(x),0.8*sqrt(x))
			else:
				i.scale = Vector2(0.5*sqrt(x),0.5*sqrt(x))

func getzoom():
	return get_node("PlayerIcon/Camera2D").zoom.x
	
func _input(event):
	if event is InputEventMouseButton:
		if event.is_pressed():
			if event.button_index == BUTTON_WHEEL_UP:
				zoom(getzoom()*0.95)
			if event.button_index == BUTTON_WHEEL_DOWN:
				zoom(getzoom()*1.05)
# TODO
# Dynamic enemy & objective pointer
# Zoom in & Zoom out centered around the player
# non-linear icon scaling (DONE)
# Limit zooming 
