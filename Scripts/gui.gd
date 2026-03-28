extends Control

@onready var transition_anim: AnimationPlayer = %TransitionAnim

func transition_scene_to(new_scene: PackedScene, scene_is_reality: bool = true) -> void:
	if transition_anim.is_playing(): printerr("Scene is already transitioning!")
	
	transition_anim.play("Fade In")
	await transition_anim.animation_finished
	
	get_tree().change_scene_to_packed(new_scene)
	await get_tree().root.child_entered_tree
	
	if scene_is_reality: Global.play_BGM_real()
	else: Global.play_BGM_imaginary()
	
	transition_anim.play("Fade Out")
