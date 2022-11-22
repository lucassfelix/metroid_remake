extends Node

export (Resource) var introAudioEvent
export (Resource) var brinstarAudioEvent


func _ready():
	$Player._disable()
	$Player/AnimatedSprite._disable()
	$Player/AnimatedSprite.play("front")
	AudioManager.play_music(introAudioEvent)
	yield($Player/AnimatedSprite,"animation_finished")
	get_parent().get_child(2).on_game_start()
	$Player._reenable()
	$Player/AnimatedSprite._reenable()
	$Spawner._spawn_enemy()
	$Spawner2._spawn_enemy()
	AudioManager.play_music(brinstarAudioEvent)
	
