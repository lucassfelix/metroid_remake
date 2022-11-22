extends Control

var _life : int

func _on_Player_health_changed(new_value):
	print(new_value)
	if new_value < 0:
		new_value = 0
	$Energy_Num.text = str(new_value)
