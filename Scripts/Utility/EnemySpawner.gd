class_name EnemySpawner
extends Node

export (PackedScene) var enemy_prefab

var _isAlive : bool
var _disabled : bool

func _ready():
	_isAlive = false
	var _err := connect("area_entered",self,"_on_area_entered")
	_err = connect("area_exited",self,"_on_area_exited")
	_spawn_enemy()
	
func _spawn_enemy():
	var new_enemy = enemy_prefab.instance()
	add_child(new_enemy)
	new_enemy.inicialize(self)
	_isAlive = true
			
func _disable():
	_disabled = true
	set_physics_process(false)
	set_process(false)	

func _reenable():
	_disabled = false
	set_physics_process(true)
	set_process(true)
	if !_isAlive:
		_spawn_enemy()
		
func enemy_defeated():
	_isAlive = false
	
func _on_area_entered(area : Area2D):
	if area.collision_layer == Constants.CAMERA_LAYER:
		if _disabled:
			_reenable()
	pass	

func _on_area_exited(area : Area2D):
	if area.collision_layer == Constants.CAMERA_LAYER:
		_disable()
	pass	
