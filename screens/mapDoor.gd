extends TileMap


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func _input(event):
	if event.is_action_pressed("ui_accept"):
		changeDoorState()

func changeDoorState():
	for i in get_used_cells():
		set_cell(i[0] , i[1], 1 - get_cell(i[0] , i[1]), 
			is_cell_x_flipped(i[0] , i[1]), 
			is_cell_y_flipped(i[0] , i[1]),
			is_cell_transposed(i[0],i[1]))

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
