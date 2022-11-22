extends Area2D

class_name Enemy

export var health : int = 2
export var damage: int = 8
export var speed: float = 4
export var direction : Vector2 = Vector2.RIGHT
export var invincible : bool = false

var _can_move := true
var _move_timer : float
var _invincible : bool
var _dead : bool
var _invincivility_timer : float


func _ready() -> void:
	var _err := connect("area_entered",self,"_on_collision")
	_err = connect("body_entered",self,"_on_collision_body")
	_dead = false
	_invincible = false
	_invincivility_timer = Constants.ENEMY_INVINCIBILITY_TIME
	
func _hitstop():
	_move_timer = Constants.HITSTOP_TIME

func _disable_movement():
	_can_move = false

func _reenable_movement():
	_can_move = true
	
func take_damage(var damage_taken : int) -> void:
	_disable_movement()	
	health -= damage_taken
	if health <= 0:
		_dead = true;
		_die()
	else:
		_hitstop()
		_activate_invincibility()

func _activate_invincibility():
	_invincible = true
	_invincivility_timer = Constants.ENEMY_INVINCIBILITY_TIME

func _check_invincibility(delta):
	if _invincible:
		_invincivility_timer -= delta
		if _invincivility_timer <= 0:
			_invincible = false

func _on_collision(area : Area2D):
	#print("Colisão de Area com ", area.name)
	if area.collision_layer == Constants.BEAM_LAYER:
		if !_invincible:
			take_damage(1)
	pass	

func _on_collision_body(node : Node):
	#print("Colisão de Body com ", node.name)
	pass	

func _process(_delta):
	pass
	
func _physics_process(delta):
	
	_check_invincibility(delta)
	
	if _move_timer <= 0 and !_dead and !_can_move:
		_reenable_movement()
	
	if _can_move:
		_movement(delta)
	else:
		_move_timer -= delta

func _movement(_delta : float):
	pass
	
func _die() -> void:
	queue_free()
	pass

