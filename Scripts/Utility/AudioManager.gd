extends Node

var _audioStreamPool : Array
var _avaliablePool : Array
var _musicStreamPlayer : AudioStreamPlayer

func _ready():
	
	_musicStreamPlayer = AudioStreamPlayer.new()
	add_child(_musicStreamPlayer)
	
	for i in range(10):
		var newAudioStream := _create_audio_stream(i)
		_audioStreamPool.append(newAudioStream)
		_avaliablePool.append(true)
	pass
	
func _create_audio_stream(var index : int) -> AudioStreamPlayer:
	var newAudioStream := AudioStreamPlayer.new()
	var _err := newAudioStream.connect("finished",self,"_on_Audio_Finished",[index])
	add_child(newAudioStream)
	return newAudioStream

func play_sfx(soundEvent : WavAudioEvent) -> void:
	
	var audioStream : AudioStreamPlayer = null
	
	for i in range(_audioStreamPool.size()):
		if _avaliablePool[i]:
			_avaliablePool[i] = false
			audioStream = _audioStreamPool[i]
	
	if audioStream == null:
		audioStream = _create_audio_stream(_audioStreamPool.size())
		_audioStreamPool.append(audioStream)
		_avaliablePool.append(false)
		
			
	audioStream.stream = soundEvent.WavAudioClip
	audioStream.volume_db = soundEvent.volume_dB
	audioStream.pitch_scale = soundEvent.pitch
	audioStream.play()
	
func play_music(musicEvent : MP3AudioEvent) -> void:
	
	_musicStreamPlayer.stop()
	_musicStreamPlayer.stream = musicEvent.MP3AudioClip
	_musicStreamPlayer.volume_db = musicEvent.volume_dB
	_musicStreamPlayer.pitch_scale = musicEvent.pitch
	_musicStreamPlayer.play()
	

func _on_Audio_Finished(var index : int):
	_avaliablePool[index] = true
