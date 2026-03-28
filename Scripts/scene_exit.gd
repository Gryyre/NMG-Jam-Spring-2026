extends Area3D

@export var to_scene: PackedScene
@export var to_scene_is_real: bool = true

func _ready() -> void:
	body_entered.connect(func(_body: Node3D): transition_to_scene())

func transition_to_scene() -> void:
	get_tree().call_group("Player", "set_movement", false)
	GUI.transition_scene_to(to_scene, to_scene_is_real)
