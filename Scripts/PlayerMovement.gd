extends KinematicBody2D

export (int) var run_speed = 100
export (int) var jump_speed = 500
export (int) var gravity = 1200
export var rotation_speed = 1.5

var velocity = Vector2()
var jumping = false

func get_input():
	velocity.x = 0
	var right = Input.is_action_pressed("walk_right")
	var left = Input.is_action_pressed("walk_left")
	var jump = Input.is_action_just_pressed("jump")

	if jump and is_on_floor():
		jumping = true
		velocity.y = -jump_speed
	if right:
		velocity.x += run_speed
		$AnimatedSprite.flip_h = false
	if left:
		velocity.x -= run_speed
		$AnimatedSprite.flip_h = true

func _physics_process(delta):
	
	if is_on_floor():
		$AnimatedSprite.set_grounded(true)
	else:
		$AnimatedSprite.set_grounded(false)
	
	get_input()
	
	velocity.y += gravity * delta
	if jumping and is_on_floor():
		jumping = false
	velocity = move_and_slide(velocity, Vector2(0, -1))
