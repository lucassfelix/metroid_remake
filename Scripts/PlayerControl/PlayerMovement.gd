class_name PlayerMovement
extends KinematicBody2D

export (float) var run_speed = 24.0
export (int) var jump_speed = 250
export (float) var knockback_strenght = 10.0
export (float) var jump_apex = 3.3
export (float) var _gravity = 6
export (Resource) var jumpAudioEvent

var _velocity : Vector2
var jumping = false
var debugIncrement : Vector2
var _disabled : bool

signal change_ui_energy(_energy)

func _ready():
	_disable()

func _disable():
	_disabled = true
	set_physics_process(false)
	set_process(false)	

func _reenable():
	_disabled = false
	set_physics_process(true)
	set_process(true)

func get_input():
	var right = Input.is_action_pressed("walk_right")
	var left = Input.is_action_pressed("walk_left")
	var aim = Input.is_action_pressed("aim_up")
	
	var _jump_pressed = Input.is_action_just_pressed("jump")
	var _jump_released = Input.is_action_just_released("jump")
	
	if _jump_pressed and is_on_floor():
		_do_jump()
	
	if _jump_released and _velocity.y < 0.0:
		_jump_cutoff()
		
		
	if right:
		_velocity.x += run_speed
		$AnimatedSprite.flip_h = false
	if left:
		_velocity.x -= run_speed
		$AnimatedSprite.flip_h = true
	
	#Sends inputs to Cannon Controller.
	$Cannon.set_beam_direction($AnimatedSprite.flip_h,aim)		

func _process(_delta):
	_velocity.x = 0	
	get_input()
	
	
func _physics_process(delta):
	
	if is_on_floor():
		$AnimatedSprite.set_grounded(true)
	else:
		_velocity.y += _gravity	
		$AnimatedSprite.set_grounded(false)

	
	if jumping and is_on_floor():
		jumping = false
		
	var _err = move_and_slide(_velocity,Vector2(0,-1))

func _do_jump():
	jumping = true
	_velocity.y = -jump_speed
	AudioManager.play_sfx(jumpAudioEvent)

func _continue_jump():
	_velocity.y -= jump_speed	
	pass
	
func _jump_cutoff():
	_velocity.y *= 0.1
	pass

func _on_enemy_contact(enemy_area2D):
	var knockback_dir : Vector2 = global_position - enemy_area2D.global_position
	_velocity += knockback_dir * knockback_strenght

func _on_Area2D_health_changed(new_value):
	emit_signal("change_ui_energy",new_value)
