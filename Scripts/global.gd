extends Node

@onready var rng: RandomNumberGenerator = RandomNumberGenerator.new()
@onready var BGM_real: AudioStreamPlayer = %RealBGM
@onready var BGM_imaginary: AudioStreamPlayer = %ImaginaryBGM

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

# Play a sound effect at a specified position in 3D space
func play_sound(global_pos: Vector3, audio_file: AudioStream, volume_adjustment: float = 0.0) -> void:
	var audio_player: AudioStreamPlayer3D = AudioStreamPlayer3D.new()
	audio_player.stream = audio_file
	audio_player.bus = "Sound Effects"
	audio_player.volume_db = volume_adjustment
	
	# Slightly randomize the pitch of sound effects so that they don't sound repetitive
	audio_player.pitch_scale = rng.randf_range(0.9, 1.1)
	
	# Spawn the audio player, make it automatically delete itself when it's done playing, then play the audio
	add_child(audio_player)
	audio_player.global_position = global_pos
	audio_player.finished.connect(audio_player.queue_free) # Delete the *audio player*, not the Global node...
	audio_player.play()

func play_BGM_real() -> void:
	BGM_imaginary.stop()
	if not BGM_real.playing:
		BGM_real.play()

func play_BGM_imaginary() -> void:
	BGM_real.stop()
	if not BGM_imaginary.playing:
		BGM_imaginary.play()
