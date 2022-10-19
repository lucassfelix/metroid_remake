class_name ZoomerBehaviour
extends Enemy

onready var _frontRaycast = $CheckGroundFront
onready var _backRaycast = $CheckGroundBack


func _ready():
	pass
	
func _process(delta):
	._process(delta);
	
func _physics_process(delta):
	._physics_process(delta)
	_check_raycasts()
	
func _movement(delta : float):
	global_position = 	global_position + (direction * speed * delta)

func _check_raycasts():
	if !_frontRaycast.is_colliding() and !_backRaycast.is_colliding():
		#O Zoomer deve trocar de direção
		_spin_right()

func _spin_left():
	print("Girou para a esquerda.")		
	var angle := -90
	var new_x : float = direction.x * cos(deg2rad(angle)) - direction.y * sin(deg2rad(angle))
	var new_y : float = direction.x * sin(deg2rad(angle)) + direction.y * cos(deg2rad(angle))
	direction = Vector2(new_x,new_y)
	global_rotation_degrees += angle

func _spin_right():
	print("Girou para a direita.")	
	var angle := 90
	var new_x : float = direction.x * cos(deg2rad(angle)) - direction.y * sin(deg2rad(angle))
	var new_y : float = direction.x * sin(deg2rad(angle)) + direction.y * cos(deg2rad(angle))
	direction = Vector2(new_x,new_y)
	get_transform().rotated(deg2rad(angle))


func _on_collision(area : Area2D):
	._on_collision(area);
	if area.collision_layer == 4:
		_spin_left()
		
func _on_collision_body(node : Node):
	._on_collision_body(node);
	if node.collision_layer == 4:
		_spin_left()
