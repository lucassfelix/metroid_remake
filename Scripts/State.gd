extends Node
class_name State

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func change_to(next_state : State) -> bool:
	#Não conseguiu trocar.
	return false
	
func _process(delta):
	pass

func _physics_process(delta):
	pass
