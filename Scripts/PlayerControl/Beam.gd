class_name Beam
extends Area2D
#Classe que define o comportamento do projétil lançado pelo jogador

export var speed : float = 240;
export var damage : int = 1;

export var beam_texture : Texture;
export var explosion_texture : Texture;

var _lifetime : float = 0.2
var _cannon : Node;
var _direction : Vector2;
var _disabled : bool

func _ready() -> void:
	var _err := connect("area_entered",self,"_on_collision")
	_err = connect("body_entered",self,"_on_collision_body")

#Inicialização
func init(start_position : Vector2,direction : Vector2, cannon : Node):
	global_position = start_position
	$beam_sprite.texture = beam_texture
	_cannon = cannon
	_direction = direction
	_disabled = false	
	_self_destroy(_lifetime)
	
func _self_destroy(time_s : float):
	yield(get_tree().create_timer(time_s), "timeout")
	disable_shot()	
	destroy_shot()

func _physics_process(delta):
	global_position = 	global_position + (_direction * speed * delta)

func destroy_shot():
	queue_free()

func disable_shot():
	if _disabled:
		return
	_cannon.decrease_shots()	
	_disabled = true
	set_physics_process(false)
	set_process(false)	
	disconnect("area_entered",self,"_on_collision")
	disconnect("body_entered",self,"_on_collision_body")

func _on_collision(area : Area2D):
	$beam_sprite.texture = explosion_texture	
	disable_shot()
	pass	

func _on_collision_body(node : Node):
	$beam_sprite.texture = explosion_texture	
	disable_shot()
	pass	
