extends CanvasLayer

var _camera_ref : Camera2D
var _offset_X : float
var _offset_Y : float

func _ready():
	$Energy_Num.text = str(Constants.INITIAL_ENERGY)	
	visible = false

func _process(_delta):
	var start = Input.is_action_just_pressed("start")
	if start:
		get_tree().change_scene("res://Scenes/MainGame.tscn")
		

func _on_Player_change_ui_energy(energy):
	if energy < 0:
		energy = 0
	$Energy_Num.text = str(energy)

func on_game_start():
	visible = true
