extends TextureRect

var rng : RandomNumberGenerator = RandomNumberGenerator.new()

func _ready():
	rng.randomize()

func _process(_delta):
	texture.noise.seed += rng.randi_range(1, 5)
