class_name Beam
extends Area2D
#Classe que define o comportamento do projétil lançado pelo jogador

export var speed : float = 240;
export var damage : int = 1;

export var beam_texture : Texture;
export var explosion_texture : Texture;

var _direction : Vector2;

func _ready() -> void:
	var _err := connect("area_entered",self,"_on_collision")
	_err = connect("body_entered",self,"_on_collision_body")

#Inicialização
func init(direction : Vector2):
	$beam_sprite.texture = beam_texture
	_direction = direction

func _physics_process(delta):
	global_position = 	global_position + (_direction * speed * delta)

func _on_collision(area : Area2D):
	print("Collided.")
	queue_free()
	pass	

func _on_collision_body(node : Node):
	print("Collided.")	
	queue_free()	
	pass	
