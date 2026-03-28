extends Area3D

@export var key_name: String = ""
@export var to_scene: PackedScene
@export var to_scene_is_real: bool = true

func _ready() -> void:
	body_entered.connect(func(body: Node3D): if body.is_in_group("Player"): pick_up_key())

func pick_up_key() -> void:
	# Add key to inventory and mark it as not used yet
	Global.inventory_keys[key_name] = false
	GUI.add_key()
	
	get_tree().call_group("Player", "set_movement", false)
	GUI.transition_scene_to(to_scene, to_scene_is_real)
