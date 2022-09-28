extends Node
#Script that changes window size on startup.
func _init():
	OS.window_size = Vector2(1024,960)
	OS.window_position = Vector2(0,0)
	queue_free()
