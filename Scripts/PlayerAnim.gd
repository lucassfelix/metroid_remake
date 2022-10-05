extends KinematicBody2D

var speed : float = 100

func _ready():
	pass # Replace with function body.
	
func _physics_process(delta):
	if Input.is_action_pressed("walk_right") :
		position.x += 1
		$AnimatedSprite.play("walk")
