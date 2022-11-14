extends KinematicBody2D

export (float) var run_speed = 24.0
export (int) var jump_speed = 500
export (int) var gravity = 1200
export var rotation_speed = 1.5

var direction : Vector2
var jumping = false
var debugIncrement : Vector2
var _delta : float

func _start():
	pass
	
func get_input():
	direction.x = 0
	var right = Input.is_action_pressed("walk_right")
	var left = Input.is_action_pressed("walk_left")
	var jump = Input.is_action_just_pressed("jump")
	var aim = Input.is_action_pressed("aim_up")

	$Cannon.set_beam_direction($AnimatedSprite.flip_h,aim)		
	
	if jump and is_on_floor():
		jumping = true
		direction.y = -jump_speed
	if right:
		direction.x += run_speed
		$AnimatedSprite.flip_h = false
	if left:
		direction.x -= run_speed
		$AnimatedSprite.flip_h = true

func _process(_delta):
	get_input()
	
func _physics_process(delta):
	
	if is_on_floor():
		$AnimatedSprite.set_grounded(true)
	else:
		$AnimatedSprite.set_grounded(false)

	direction.y += gravity * delta

	if jumping and is_on_floor():
		jumping = false
		
	move_and_slide(direction,Vector2(0,-1))
