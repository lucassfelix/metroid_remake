extends Control

func _on_Player_change_ui_energy(_energy):
	if _energy < 0:
		_energy = 0
	$Energy_Num.text = str(_energy)
