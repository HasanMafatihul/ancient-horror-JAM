extends Area2D

# How to use:
#	+ Add object bound to interactable object to "interact" group
#	+ Add object's function in interact() function

export var main : NodePath
export var clue : String

func interact():
	get_node(main).show_clue(clue)
