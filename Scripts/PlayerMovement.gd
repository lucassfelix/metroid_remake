extends KinematicBody2D

export (float) var run_speed = 24.0
export (int) var jump_speed = 500
export (float) var jump_height = 3.3
export (float) var time_to_apex = 2.5
export (float) var downward_gravity_mult = 3

export var rotation_speed = 1.5


var direction : Vector2
var jumping = false
var debugIncrement : Vector2
var _gravity : float
var _delta : float

func _start():
	pass

func _set_gravity():
	_gravity = jump_height*2 / (time_to_apex*time_to_apex)
	pass


func get_input():
	direction.x = 0
	var right = Input.is_action_pressed("walk_right")
	var left = Input.is_action_pressed("walk_left")
	var jump = Input.is_action_just_pressed("jump")
	var aim = Input.is_action_pressed("aim_up")

	$Cannon.set_beam_direction($AnimatedSprite.flip_h,aim)		
	
	if jump and is_on_floor():
		_do_jump()
	if right:
		direction.x += run_speed
		$AnimatedSprite.flip_h = false
	if left:
		direction.x -= run_speed
		$AnimatedSprite.flip_h = true

func _process(_delta):
	get_input()
	
func _do_jump():
	jumping = true
	direction.y = -jump_speed
	
func _calculate_gravity():
	pass
	
func _physics_process(delta):
	
	if is_on_floor():
		$AnimatedSprite.set_grounded(true)
	else:
		direction.y += _gravity * delta
		$AnimatedSprite.set_grounded(false)


	if jumping and is_on_floor():
		jumping = false
		
	move_and_slide(direction,Vector2(0,-1))
