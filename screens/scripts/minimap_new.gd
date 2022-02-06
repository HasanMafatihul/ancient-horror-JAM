extends Sprite

const zero = Vector2(790.017273, 59.390175)
const maxim = Vector2(912.489014, 220.571442)
const map_zero = Vector2(-2082, -5584)
const map_maxim = Vector2(3646, 2689)

export var main_path : NodePath
onready var main_level : Node2D = get_node(main_path)

func _ready():
	$AnimationPlayer.play("blinking enemy")

func _process(delta):
	$monster_1.global_position = (main_level.get_node("monster_1").position - map_zero) * (maxim - zero)/(map_maxim - map_zero) + zero
	$monster_2.global_position = (main_level.get_node("monster_2").position - map_zero) * (maxim - zero)/(map_maxim - map_zero) + zero
