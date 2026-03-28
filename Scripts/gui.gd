extends Control

@onready var transition_anim: AnimationPlayer = %TransitionAnim

@onready var key_GUI: TextureRect = %KeyGUI
const TEXTURE_KEYS_0 = preload("res://2D Art/Icon/Key_0.PNG")
const TEXTURE_KEYS_1 = preload("res://2D Art/Icon/Key_1.PNG")
const TEXTURE_KEYS_2 = preload("res://2D Art/Icon/Key_2.PNG")
const TEXTURE_KEYS_3 = preload("res://2D Art/Icon/Key_3.PNG")

var num_keys: int = 0

func add_key() -> void:
	num_keys = min(num_keys + 1, 3)
	set_key_texture()
func remove_key() -> void:
	num_keys = max(num_keys - 1, 0)
	set_key_texture()
func set_key_texture() -> void:
	match num_keys:
		0: key_GUI.texture = TEXTURE_KEYS_0
		1: key_GUI.texture = TEXTURE_KEYS_1
		2: key_GUI.texture = TEXTURE_KEYS_2
		3: key_GUI.texture = TEXTURE_KEYS_3

func transition_scene_to(new_scene: PackedScene, scene_is_reality: bool = true, spawn_point_title: String = "") -> void:
	if transition_anim.is_playing(): printerr("Scene is already transitioning!")
	if spawn_point_title == "":
		printerr("No spawn point set for new scene!")
		return
	
	transition_anim.play("Fade In")
	await transition_anim.animation_finished
	
	get_tree().change_scene_to_packed(new_scene)
	await get_tree().root.child_entered_tree
	
	get_tree().call_group("Player", "move_to_spawn_point", spawn_point_title)
	
	if scene_is_reality: Global.play_BGM_real()
	else: Global.play_BGM_imaginary()
	
	get_tree().call_group("Player", "set_movement", true)
	transition_anim.play("Fade Out")
