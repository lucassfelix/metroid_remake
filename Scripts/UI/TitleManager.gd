class_name TitleManager
extends Control

export (Resource) var titleSong 

func _ready():
	AudioManager.play_music(titleSong)
	$AnimatedSprite.play("default")

