class_name CannonControl
extends Node2D

export var beam_prefab: PackedScene = preload("res://Scenes/Prefabs/Beam.tscn")
export (Resource) var shootAudioEvent

var can_shoot : bool = true;
var concurrent_beams : int = 0
var _direction : Vector2 = Vector2.RIGHT
var _hold_timer : float


func increase_shots():
	concurrent_beams += 1

func decrease_shots():
	concurrent_beams -= 1	

func set_beam_direction(flipH : bool, up:bool):
	if up:
		_direction = Vector2.UP
		if !flipH:
			set_position($UpRight.get_position())
		else:
			set_position($UpLeft.get_position())
	elif !flipH:
		_direction = Vector2.RIGHT		
		set_position($RightPos.get_position())
	else:
		_direction = Vector2.LEFT		
		set_position($LeftPos.get_position())				
			

func delay_shot():
	yield(get_tree().create_timer(Constants.DELAY_BETWEEN_SHOTS),"timeout");
	can_shoot = true;

func on_shoot_pressed():
	
	if can_shoot and concurrent_beams < 3:
		can_shoot = false
		delay_shot()
		increase_shots()
		var new_beam : Beam = beam_prefab.instance()
		get_tree().get_root().get_child(0).add_child(new_beam)
		AudioManager.play_sfx(shootAudioEvent)	
		new_beam.init(global_position,_direction,self)
	
func _process(delta):
	var shoot_just_pressed = Input.is_action_just_pressed("shoot")
	var shoot_pressed = Input.is_action_pressed("shoot")
	
	if shoot_pressed:
		_hold_timer -= delta
		if _hold_timer <= 0:
			on_shoot_pressed()
	
	if shoot_just_pressed:
		_hold_timer = Constants.HOLD_DELAY
		on_shoot_pressed()
