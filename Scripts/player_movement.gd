extends CharacterBody3D

const SPEED = 5.0
const JUMP_VELOCITY = 4.5

var mouse_sensitivity = 0.008
var keyboard_camera_sensitivity = 10
@onready var camera: Camera3D = %Camera

var movement_enabled: bool = true
func set_movement(enabled: bool) -> void:
	movement_enabled = enabled

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		#printt(event.screen_relative, rad_to_deg(rotation.y))
		rotate_camera(event.screen_relative)

func rotate_camera(input: Vector2) -> void:
	# Rotate body for horizontal rotation
	rotate_y(-input.x * mouse_sensitivity)
	
	# Rotate camera for vertical rotation
	camera.rotate_x(-input.y * mouse_sensitivity)
	camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-60), deg_to_rad(60))

# This makes it easier to use the camera while walking if playing with a trackpad
func handle_keyboard_camera_control() -> void:
	var camera_vector: Vector2 = Input.get_vector("camera_left", "camera_right", "camera_up", "camera_down")
	camera_vector *= keyboard_camera_sensitivity
	rotate_camera(camera_vector)

func _physics_process(delta: float) -> void:
	handle_keyboard_camera_control()
	
	if Input.is_action_just_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	elif Input.is_action_just_pressed("interact"):
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	if movement_enabled:
		handle_movement(delta)

func handle_movement(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	# Get the input direction and handle the movement/deceleration.
	var input_dir := Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	
	move_and_slide()

func move_to_spawn_point(spawn_name: String) -> void:
	for exit: Area3D in get_tree().get_nodes_in_group("Exit"):
		if exit.exit_name == spawn_name:
			global_position = exit.spawn_marker.global_position
