extends Control

func _ready():
	$Energy_Num.text = str(Constants.INITIAL_ENERGY)	

func _on_Player_change_ui_energy(_energy):
	if _energy < 0:
		_energy = 0
	$Energy_Num.text = str(_energy)
