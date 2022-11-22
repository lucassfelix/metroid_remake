class_name TitleManager
extends Control

export (Resource) var titleSong 

func _ready():
	AudioManager.play_music(titleSong)
	_play_loop()

func _play_loop() -> void:
	$AnimatedSprite.play("default")
	yield($AnimatedSprite, "animation_finished")
	yield(get_tree().create_timer(4), "timeout")
	
	$AnimatedSprite.play("blink-in")
	yield($AnimatedSprite, "animation_finished")
	yield(get_tree().create_timer(2), "timeout")
	
	$AnimatedSprite.play("blink-out")
	yield($AnimatedSprite, "animation_finished")
	
	$AnimatedSprite.play("text")
	yield($AnimatedSprite, "animation_finished")
	yield(get_tree().create_timer(4), "timeout")
	
	_play_loop()
