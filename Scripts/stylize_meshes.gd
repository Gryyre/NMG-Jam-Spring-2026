extends Node3D

@export var shader_material: ShaderMaterial = preload("res://Resources/Shaders/Outline Material.tres")
@export var mesh_colors: Array[Color]

const BASIC_MATERIAL = preload("res://3D Art/Generic Materials/Basic Material.tres")

func print_palette() -> void:
	for i in mesh_colors.size():
		print_rich("[color=#{color}]Color #{num}".format(
			{"color": mesh_colors[i].to_html(false), "num": i+1}
		))

func _ready() -> void:
	#print_palette()
	
	var i: int = 0
	for node: Node in get_tree().get_first_node_in_group("Scalable").get_children():
		if not (node is MeshInstance3D): continue
		
		var mesh: Mesh = node.mesh
		
		#if not mesh.surface_get_material(0):
		for surface_num in mesh.get_surface_count():
			mesh.surface_set_material(surface_num, BASIC_MATERIAL.duplicate())
		
		# Get a unique duplicate of the mesh's material
		
		
		# Meshes are assigned random colors within their palette
		# However the colors should be consistent between playthroughs,
		# so seed the colors based on the mesh's index.
		Global.rng.set_seed(hash(i))
		#printt(node.position, Global.rng.seed, Global.rng.randi_range(0, mesh_colors.size() - 1))
		
		for surface_num in mesh.get_surface_count():
			var mesh_material: StandardMaterial3D = mesh.surface_get_material(surface_num)
			mesh_material.albedo_color = mesh_colors[
				Global.rng.randi_range(0, mesh_colors.size() - 1)
			]
			mesh.surface_set_material(surface_num, mesh_material)
			
			# Automatically set the next pass of each mesh's material to be the shader material
			mesh_material.next_pass = shader_material
		
		#print_rich("[color=#{color}]{mesh}".format(
			#{"color": mesh_material.albedo_color.to_html(false), "mesh": node.name}
		#))
		
		i += 1
