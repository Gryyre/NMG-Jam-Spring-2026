extends Area3D

@export var key_name: String = ""
@export var to_scene: PackedScene
@export var to_scene_is_real: bool = true

func _ready() -> void:
	body_entered.connect(func(_body: Node3D): pick_up_key())

func pick_up_key() -> void:
	Global.inventory_keys.append(key_name)
	
	get_tree().call_group("Player", "set_movement", false)
	GUI.transition_scene_to(to_scene, to_scene_is_real)
