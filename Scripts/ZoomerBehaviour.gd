class_name ZoomerBehaviour
extends Enemy

onready var _frontRaycast = $CheckGroundFront
onready var _backRaycast = $CheckGroundBack

var waiting_back := false

func _ready():
	pass
	
func _process(_delta):
	#Chamar a função pai no callback faz com que ela seja executada 2 vezes.	
	#._process(delta);
	pass
	
func _physics_process(_delta):
	#Chamar a função pai no callback faz com que ela seja executada 2 vezes.
	#._physics_process(delta)
	
	_check_raycasts()
	
func _movement(delta : float):
	var increment = (direction * speed * delta) 
	global_position = global_position + increment

func _check_raycasts():
	if !_frontRaycast.is_colliding():
		waiting_back = true
	
	if !_backRaycast.is_colliding() and waiting_back:
		#O Zoomer deve trocar de direção
		_spin_right()
		waiting_back = false

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
	if area.collision_layer == 4:
		_spin_left()
		
func _on_collision_body(node : Node):
	._on_collision_body(node);
	if node.collision_layer == 4:
		_spin_left()
