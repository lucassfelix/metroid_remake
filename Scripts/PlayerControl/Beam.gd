class_name Beam
extends RigidBody2D
#Classe que define o comportamento do projétil lançado pelo jogador

export var speed : float = 240;
export var damage : int = 1;

export var beam_texture : Texture;
export var explosion_texture : Texture;

#Inicialização
func _init(direction : Vector2):
	gravity_scale = 0;
	$beam_sprite.texture = beam_texture
	linear_velocity = direction * speed
