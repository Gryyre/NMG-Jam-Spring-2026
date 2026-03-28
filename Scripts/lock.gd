extends Node3D

@export var required_key: String = ""
@export_node_path() var exit_to_lock
@onready var locked_exit: Node3D = get_node(exit_to_lock)

func _ready() -> void:
	# Lock the exit
	locked_exit.is_unlocked = false
	
	# Automatically remove the lock if you've already unlocked the exit
	if required_key in Global.inventory_keys \
	and Global.inventory_keys[required_key] == true:
		remove_lock()

func _on_area_3d_body_entered(body: Node3D) -> void:
	if not body.is_in_group("Player"): return
	
	if required_key in Global.inventory_keys:
		# play unlocking sound
		
		remove_lock()

func remove_lock() -> void:
	locked_exit.is_unlocked = true
	Global.inventory_keys[required_key] = true
	queue_free()
