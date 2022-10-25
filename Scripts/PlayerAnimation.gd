extends AnimatedSprite

var speed : float = 100

var _grounded : bool

func _ready():
	var _grounded = true

func _process(delta):
	var walk_right = Input.is_action_pressed("walk_right")
	var walk_left = Input.is_action_pressed("walk_left")
	var jump = Input.is_action_just_pressed("jump")
	var shoot = Input.is_action_pressed("shoot")
	var aim = Input.is_action_pressed("aim_up")
	
	var spr_offset : int

	# Shooting
	if shoot and walk_right and !_grounded:
		play("jump-shoot")
		flip_h = false
	elif shoot and walk_left and !_grounded:
		play("jump-shoot")
		flip_h = true
	elif shoot and !_grounded and flip_h == false:
		play("jump-shoot")
	elif shoot and !_grounded and flip_h == true:
		play("jump-shoot")
		
	elif shoot and walk_right and _grounded:
		play("walk-shoot")
		flip_h = false
	elif shoot and walk_left and _grounded:
		play("walk-shoot")
		flip_h = true
	elif shoot and _grounded and flip_h == false:
		play("shoot")
	elif shoot and _grounded and flip_h == true:
		play("shoot")
		
#	# Aiming
#	elif aim:
#		play("aim-up")
#		spr_offset = -3 # Este valor está sendo ignorado
#		offset.y = spr_offset
#		spr_offset = 0
#		offset.y = spr_offset

	# Not shooting
	elif walk_right and !_grounded:
		play("jump-spin")
		flip_h = false
	elif walk_left and !_grounded:
		play("jump-spin")
		flip_h = true
	elif jump and _grounded:
		_grounded = false
		play("jump")
	
	# Grounded
	elif walk_right and _grounded:
		play("walk")
		flip_h = false
	elif walk_left and _grounded:
		play("walk")
		flip_h = true

	elif _grounded:
		play("idle")
		spr_offset = 0

		
func grounded():
	_grounded = true
