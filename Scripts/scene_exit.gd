extends Area3D

@export var exit_name: String = ""
@export var to_scene: PackedScene
@export var to_scene_exit_name: String = ""
@export var to_scene_is_real: bool = true

var is_unlocked: bool = true

@onready var spawn_marker: Marker3D = %SpawnMarker

func _ready() -> void:
	if not to_scene:
		printerr("To Scene is not valid.")
		return
	
	body_entered.connect(func(body: Node3D):
		if body.is_in_group("Player") and is_unlocked:
			transition_to_scene()
	)

func transition_to_scene() -> void:
	get_tree().call_group("Player", "set_movement", false)
	GUI.transition_scene_to(to_scene, to_scene_is_real, to_scene_exit_name)
