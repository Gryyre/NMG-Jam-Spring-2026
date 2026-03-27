extends Node3D

const SFX_TEST = preload("res://Audio/Sound Effects/audio_test_sound_short.mp3")

func _ready() -> void:
	var timer: Timer = Timer.new()
	timer.autostart = true
	timer.one_shot = false
	timer.wait_time = 0.4
	timer.timeout.connect(play_sound)
	add_child(timer)

func play_sound() -> void:
	Global.play_sound(global_position, SFX_TEST)
