extends AnimatedSprite

var speed : float = 100
var _grounded : bool
var _walked : bool
var _shouldWalk : bool
var _disabled : bool

export (Resource) var walkAudioEvent

func _ready():
	_grounded = true
	_disable()

func _walking_sound():
	#AudioManager.play_sfx(walkAudioEvent)
	_walked = true
	#yield(get_tree().create_timer(0.2),"timeout")
	_walked = false
	
func _disable():
	_disabled = true
	set_physics_process(false)
	set_process(false)	

func _reenable():
	_disabled = false
	set_physics_process(true)
	set_process(true)

	
func _process(_delta):
	var walk_right = Input.is_action_pressed("walk_right")
	var walk_left = Input.is_action_pressed("walk_left")
	var jump = Input.is_action_just_pressed("jump")
	var shoot = Input.is_action_pressed("shoot")
	var aim = Input.is_action_pressed("aim_up")
	
	var spr_offset : int
		
	spr_offset = 0
	offset.y = spr_offset
	
	if aim:
		spr_offset = -2
		offset.y = spr_offset
		
#	# Aiming
	if aim and !_grounded:
		play("aim-up-jump")
	elif aim and walk_right and _grounded:
		play("aim-up-walk")
		_shouldWalk = true
		
	elif aim and walk_left and _grounded:
		play("aim-up-walk")
		_shouldWalk = true
		
	elif aim and _grounded:
		play("aim-up")

	# Shooting airbourne
	elif shoot and walk_right and !_grounded:
		play("jump-shoot")
	elif shoot and walk_left and !_grounded:
		play("jump-shoot")
	elif shoot and !_grounded:
		play("jump-shoot")
		
	# Shooting on floor
	elif shoot and walk_right and _grounded:
		play("walk-shoot")
		_shouldWalk = true
		
	elif shoot and walk_left and _grounded:
		play("walk-shoot")
		_shouldWalk = true
		
	elif shoot and _grounded:
		play("shoot")

	# Airbourne
	elif !_grounded:
		play("jump")
	elif walk_right and !_grounded:
		play("jump-spin")
	elif walk_left and !_grounded:
		play("jump-spin")
	
	# On floor
	elif jump and _grounded:
		play("jump")
	elif walk_right and _grounded:
		play("walk")
		_shouldWalk = true
	elif walk_left and _grounded:
		play("walk")
		_shouldWalk = true
		

	elif _grounded:
		play("idle")
		spr_offset = 0
		offset.y = spr_offset

	if _shouldWalk and !_walked:
		_walking_sound() 

func set_grounded(value : bool):
	_grounded = value
