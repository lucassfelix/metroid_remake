extends Area2D

class_name Enemy

export var health : int = 2
export var damage: int = 8
export var speed: float = 4
export var direction : Vector2 = Vector2.RIGHT
export var invincible : bool = false

var _can_move := true
var _move_timer : float

var LAYER_BEAM : int = 8
var LAYER_PLAYER : int = 1
var HITSTOP_TIME : float = 0.2

func _ready() -> void:
	var _err := connect("area_entered",self,"_on_collision")
	_err = connect("body_entered",self,"_on_collision_body")
	
	pass
	
func _hitstop():
	_can_move = false
	_move_timer = HITSTOP_TIME
	
func _reenable_movement():
	_can_move = true
	
func take_damage(var damage_taken : int) -> void:
	_hitstop()
	health -= damage_taken
	if health <= 0:
		_die()
	pass

func _on_collision(area : Area2D):
	#print("Colisão de Area com ", area.name)
	if area.collision_layer == LAYER_BEAM:
		take_damage(1)
	pass	

func _on_collision_body(node : Node):
	#print("Colisão de Body com ", node.name)
	if node.collision_layer == LAYER_BEAM:
		take_damage(1)
	pass	

func _process(_delta):
	pass
	
func _physics_process(delta):
	_move_timer -= delta
	
	if _move_timer <= 0:
		_reenable_movement()
	
	if _can_move:
		_movement(delta)
	
func _movement(_delta : float):
	pass
	
func _die() -> void:
	#Death Animation
	queue_free()
	pass

