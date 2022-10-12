extends AnimatedSprite

var speed : float = 100
var _grounded := true

func _process(delta):
	var walk_right = Input.is_action_pressed("walk_right")
	var walk_left = Input.is_action_pressed("walk_left")
	var jump = Input.is_action_pressed("jump")
	var shoot = Input.is_action_pressed("shoot")

	# Not shooting
	if jump and _grounded:
		_grounded = false
		play("jump")
	elif walk_right and _grounded:
		play("walk")
		flip_h = false
	elif walk_left and _grounded:
		play("walk")
		flip_h = true
	elif jump and walk_right:
		play("jump-spin")
		flip_h = false
	elif jump and walk_left:
		play("jump-spin")
		flip_h = true
	
	# Shooting
	elif shoot:
		play("shoot")
		flip_h = false

	elif _grounded:
		play("idle")
		
func grounded():
	_grounded = true
