extends Area2D

var _energy : int
var _invincivility_timer : float
var _invincible : bool

signal health_changed(new_value)
signal enemy_contact(area)
signal game_over()

func _ready():
	_energy = Constants.INITIAL_ENERGY
	_invincivility_timer = Constants.PLAYER_INVINCIBILITY_TIME
	_invincible = false
	var _err := connect("area_entered",self,"_on_area_entered")
	emit_signal("health_changed",_energy)

func _physics_process(delta):
	_check_invincibility(delta)

func _activate_invincibility():
	_invincible = true
	_invincivility_timer = Constants.PLAYER_INVINCIBILITY_TIME

func _check_invincibility(delta):
	if _invincible:
		_invincivility_timer -= delta
		if _invincivility_timer <= 0:
			_invincible = false

func _take_damage():
	_energy -= 8
	if _energy <= 0:
		emit_signal("game_over")
	else:
		emit_signal("health_changed", _energy)
		_activate_invincibility()

func _on_area_entered(area):
	if area.collision_layer == Constants.ENEMY_LAYER:
		if !_invincible:
			_take_damage()
			emit_signal("enemy_contact",area)

