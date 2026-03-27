extends Node

@onready var rng: RandomNumberGenerator = RandomNumberGenerator.new()

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

# Play a sound effect at a specified position in 3D space
func play_sound(global_pos: Vector3, audio_file: AudioStream, volume_adjustment: float = 0.0) -> void:
	var audio_player: AudioStreamPlayer3D = AudioStreamPlayer3D.new()
	audio_player.stream = audio_file
	audio_player.global_position = global_pos
	audio_player.bus = "Sound Effects"
	audio_player.volume_db = volume_adjustment
	
	# Slightly randomize the pitch of sound effects so that they don't sound repetitive
	audio_player.pitch_scale = rng.randf_range(0.9, 1.1)
	
	# Spawn the audio player, make it automatically delete itself when it's done playing, then play the audio
	add_child(audio_player)
	audio_player.finished.connect(queue_free)
	audio_player.play()
