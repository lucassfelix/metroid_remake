extends Control

var child : Node

var player : PackedScene = preload("res://Scenes/Prefabs/PlayerAnim.tscn")

func _on_Button_pressed():
	if !is_instance_valid(child):
		child = player.instance()
		add_child(child)
	else:
		print("Tchau")
		child.queue_free()
