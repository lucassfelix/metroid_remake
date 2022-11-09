class_name CannonControl
extends Node2D

const DELAY_BETWEEN_SHOTS : float = 0.13;

export var beam_prefab: PackedScene = preload("res://Scenes/Prefabs/Beam.tscn")

var can_shoot : bool = true;
var concurrent_beams : int = 0
var _direction : Vector2 = Vector2.RIGHT

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
	yield(get_tree().create_timer(DELAY_BETWEEN_SHOTS),"timeout");
	can_shoot = true;

func on_shoot_pressed():
	
	if can_shoot and concurrent_beams < 3:
		can_shoot = false
		delay_shot()
		increase_shots()
		var new_beam : Beam = beam_prefab.instance()
		add_child(new_beam)
		#var _err = new_beam.connect("body_entered",self,"decrease_shots")
		#_err = new_beam.connect("area_entered",self,"decrease_shots")
		new_beam.init(_direction,self)
	
func _process(delta):
	var shoot_pressed = Input.is_action_pressed("shoot")
	
	if shoot_pressed:
		on_shoot_pressed()
