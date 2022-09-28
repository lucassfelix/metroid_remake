extends Node

class_name Enemy

export var health : int = 2
export var damage: int = 8
export var speed: float = 4
export var direction : Vector2 = Vector2.RIGHT
export var invincible : bool = false

func _ready() -> void:
	pass
	
func take_damage(var damage_taken : int) -> void:
	health -= damage_taken
	if health <= 0:
		_die()
		
	pass
	
func _die() -> void:
	pass

