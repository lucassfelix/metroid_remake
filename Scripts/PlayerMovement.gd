extends KinematicBody2D

export (float) var run_speed = 24.0
export (int) var jump_speed = 500
export (float) var knockback_strenght = 10
export (float) var _gravity = 1000

var direction : Vector2
var jumping = false
var debugIncrement : Vector2
var _delta : float

signal change_ui_energy(_energy)

func get_input():
	var right = Input.is_action_pressed("walk_right")
	var left = Input.is_action_pressed("walk_left")
	var jump = Input.is_action_just_pressed("jump")
	var aim = Input.is_action_pressed("aim_up")

	$Cannon.set_beam_direction($AnimatedSprite.flip_h,aim)		

	direction.x = 0	
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
	
func _physics_process(delta):
	
	if is_on_floor():
		$AnimatedSprite.set_grounded(true)
	else:
		direction.y += _gravity * delta
		$AnimatedSprite.set_grounded(false)
		
	if jumping and is_on_floor():
		jumping = false
		
	var collision_test = move_and_collide(direction, true, true, true)
	move_and_slide(direction,Vector2(0,-1))

func _do_jump():
	jumping = true
	direction.y = -jump_speed

func _on_enemy_contact(area):
	if area.collision_layer == Constants.ENEMY_LAYER:
		var knockback_dir : Vector2 = global_position - area.global_position
		direction += knockback_dir * knockback_strenght
	pass


func _on_Area2D_health_changed(new_value):
	emit_signal()
