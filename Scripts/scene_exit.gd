extends Area3D

@export var to_scene: PackedScene
@export var to_scene_is_real: bool = true

var is_unlocked: bool = true

func _ready() -> void:
	body_entered.connect(func(body: Node3D):
		if body.is_in_group("Player") and is_unlocked:
			transition_to_scene()
	)

func transition_to_scene() -> void:
	get_tree().call_group("Player", "set_movement", false)
	GUI.transition_scene_to(to_scene, to_scene_is_real)
