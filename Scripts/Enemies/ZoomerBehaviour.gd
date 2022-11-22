class_name ZoomerBehaviour
extends Enemy

onready var _frontRaycast = $CheckGroundFront
onready var _backRaycast = $CheckGroundBack

var _waiting_back : bool
var _waiting_front : bool

func _ready():
	_waiting_back = false
	pass
	
func _physics_process(_delta):
	_check_raycasts()
	
func _movement(delta : float):
	var increment = (direction * speed * delta) 
	global_position = global_position + increment

func _die() -> void:
	#Death Animation
	$Sprite.stop()
	$Sprite.play("death")
	yield($Sprite,"animation_finished")
	._die()
	pass

func _reenable_movement():
	._reenable_movement()
	$Sprite.play("walk")

func take_damage(var damage_taken : int) -> void:
	$Sprite.play("hit")
	.take_damage(damage_taken)
	pass

func _check_raycasts():
	
	if _frontRaycast.is_colliding():
		_waiting_front = false
	
	if !_frontRaycast.is_colliding() and !_waiting_front:
		_waiting_back = true
	
	if !_backRaycast.is_colliding() and _waiting_back:
		_waiting_back = false
		_waiting_front = true
		_spin_right()

func _spin_left():
	var angle := -90
	direction = direction.rotated(deg2rad(angle))
	global_rotation_degrees += angle

func _spin_right():
	var angle := 90
	direction = direction.rotated(deg2rad(angle))
	global_rotation_degrees += angle	

func _on_collision(area : Area2D):
	._on_collision(area);
	if area.collision_layer == Constants.ENVIRONMENT_LAYER:
		_spin_left()
		
func _on_collision_body(node : Node):
	._on_collision_body(node);
	if node.collision_layer == Constants.ENVIRONMENT_LAYER:
		_spin_left()
