extends TileMap

var posTile : Vector2 # Posisi pemain dalam tile coordinate
var doorID : int
var xflip: int
var yflip: int
var transpose: int

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func _input(event):
	#Temporary button
	if event.is_action_pressed("ui_accept"):
		changeDoorState()

func changeDoorState():
	posTile = world_to_map(get_parent().get_node("player").global_position)
	for i in range(posTile.x - 2 , posTile.x + 2): # -2 ~ +1
		for j in range(posTile.y - 2 , posTile.y + 2):
			if(get_cell(i,j) != -1):
				xflip = is_cell_x_flipped(i,j)
				yflip = is_cell_y_flipped(i,j)
				transpose = is_cell_transposed(i,j)
				doorID = 4 * xflip + 2 * yflip + transpose # bitmask
				if(doorID == 0 and posTile.x-2 <= i and i <= posTile.x-1 and posTile.y-1 <= j and j <= posTile.y-0):
					changeOneDoorState(Vector2(i,j))
				if(doorID == 3 and posTile.x-1 <= i and i <= posTile.x-0 and posTile.y-0 <= j and j <= posTile.y+1):
					changeOneDoorState(Vector2(i,j))
				if(doorID == 5 and posTile.x-1 <= i and i <= posTile.x-0 and posTile.y-2 <= j and j <= posTile.y-1):
					changeOneDoorState(Vector2(i,j))
				if(doorID == 6 and posTile.x-0 <= i and i <= posTile.x+1 and posTile.y-1 <= j and j <= posTile.y-0):
					changeOneDoorState(Vector2(i,j))

func breakDoor(pos):
	posTile = world_to_map(pos)
	for i in range(posTile.x - 2 , posTile.x + 2): # -2 ~ +1
		for j in range(posTile.y - 2 , posTile.y + 2):
			if(get_cell(i,j) != -1):
				xflip = is_cell_x_flipped(i,j)
				yflip = is_cell_y_flipped(i,j)
				transpose = is_cell_transposed(i,j)
				doorID = 4 * xflip + 2 * yflip + transpose # bitmask
				if(doorID == 0 and posTile.x-2 <= i and i <= posTile.x-1 and posTile.y-1 <= j and j <= posTile.y-0):
					changeOneDoorState(Vector2(i,j))
				if(doorID == 3 and posTile.x-1 <= i and i <= posTile.x-0 and posTile.y-0 <= j and j <= posTile.y+1):
					changeOneDoorState(Vector2(i,j))
				if(doorID == 5 and posTile.x-1 <= i and i <= posTile.x-0 and posTile.y-2 <= j and j <= posTile.y-1):
					changeOneDoorState(Vector2(i,j))
				if(doorID == 6 and posTile.x-0 <= i and i <= posTile.x+1 and posTile.y-1 <= j and j <= posTile.y-0):
					changeOneDoorState(Vector2(i,j))

func changeOneDoorState(pos):
	set_cell(pos.x , pos.y, 1 - get_cell(pos.x , pos.y), 
		is_cell_x_flipped(pos.x , pos.y), # memastikan rotasi sama
		is_cell_y_flipped(pos.x , pos.y),
		is_cell_transposed(pos.x , pos.y))

