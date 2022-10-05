class_name Cannon
extends Node

const DELAY_BETWEEN_SHOTS : float = 0.13;

var can_shoot : bool = true;

func _ready():
	pass
	
func on_shot():
	can_shoot = false;
	delay_shot();
	pass
	
func delay_shot():
	yield(get_tree().create_timer(DELAY_BETWEEN_SHOTS),"timeout");
	can_shoot = true;

