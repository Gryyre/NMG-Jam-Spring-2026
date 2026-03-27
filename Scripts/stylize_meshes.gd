extends Node3D

@export var shader_material: ShaderMaterial
@export_color_no_alpha var mesh_color

func _ready() -> void:
	for node: Node in get_children():
		if not (node is MeshInstance3D): continue
		
		var mesh: Mesh = node.mesh
		var mesh_material: StandardMaterial3D = mesh.surface_get_material(0)
		
		mesh_material.albedo_color = mesh_color
		
		# Automatically set the next pass of each mesh's main material to be the shader material
		mesh_material.next_pass = shader_material
