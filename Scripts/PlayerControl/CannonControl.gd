extends Node

const DELAY_BETWEEN_SHOTS : float = 0.13;

export var beam_prefab: PackedScene = preload("res://Scenes/Prefabs/Beam.tscn")

var can_shoot : bool = true;

var concurrent_beams : int = 0

func increase_shots():
	concurrent_beams += 1

func decrease_shots():
	print("Decrease")
	concurrent_beams -= 1	
	
func delay_shot():
	yield(get_tree().create_timer(DELAY_BETWEEN_SHOTS),"timeout");
	can_shoot = true;

func on_shoot_pressed():
	
	if can_shoot and concurrent_beams < 3:
		can_shoot = false
		delay_shot()
		increase_shots()
		var new_beam : Beam = beam_prefab.instance()
		var _err = new_beam.connect("body_entered",self,"decrease_shots")
		_err = new_beam.connect("area_entered",self,"decrease_shots")
		add_child(new_beam)
		new_beam.init(Vector2.RIGHT)
	
func _process(delta):
	var shoot_pressed = Input.is_action_pressed("shoot")
	
	if shoot_pressed:
		on_shoot_pressed()
