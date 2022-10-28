extends Area2D

class_name Enemy

export var health : int = 2
export var damage: int = 8
export var speed: float = 4
export var direction : Vector2 = Vector2.RIGHT
export var invincible : bool = false

var _can_move := true
var HITSTOP_TIME : float = 0.2

func _ready() -> void:
	var _err := connect("area_entered",self,"_on_collision")
	_err = connect("body_entered",self,"_on_collision_body")
	
	pass
	
func _hitstop():
	_can_move = false
	_enable_movement(HITSTOP_TIME)
	
func _enable_movement(time_s : float):
	yield(get_tree().create_timer(time_s), "timeout")
	_can_move = true
	
func take_damage(var damage_taken : int) -> void:
	_hitstop()
	health -= damage_taken
	if health <= 0:
		_die()
	pass

func _on_collision(area : Area2D):
	print("Colisão de Area",area)
	if area.collision_layer == 8:
		take_damage(1)
	pass	

func _on_collision_body(node : Node):
	print("Colisão de Body",node)
	if node.collision_layer == 8:
		take_damage(1)
	pass	

func _process(_delta):
	pass
	
func _physics_process(delta):
	_movement(delta)
	
func _movement(_delta : float):
	pass
	
func _die() -> void:
	pass

