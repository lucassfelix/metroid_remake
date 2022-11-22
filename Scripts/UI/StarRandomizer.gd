extends Node2D

var animations = ["1", "2", "3", "4"]
var rng : int
var answer
var random_frame

func _star_rng():
	var generator = RandomNumberGenerator.new()
	generator.randomize()
	rng = generator.randi() % animations.size()
	
	return animations[rng]
	
func _frame_rng():
	var total_frames = $AnimatedSprite.frames.get_frame_count(answer)
	var generator = RandomNumberGenerator.new()
	generator.randomize()
	random_frame = generator.randi_range(0, total_frames)
	
	return random_frame
	
func _ready():
	answer = _star_rng()
	_frame_rng()
	$AnimatedSprite.play(answer)
	$AnimatedSprite.frame = random_frame
