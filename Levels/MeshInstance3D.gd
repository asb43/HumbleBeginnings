extends MeshInstance3D

var outline = preload("res://Levels/Resources/Shaders/outline.gdshader")

# This function changes the color of the mesh's material to the specified color.
func change_mesh_color(new_color: Color) -> void:
	# Check if the mesh has a material override
	var material: StandardMaterial3D = mesh.surface_get_material(0) as StandardMaterial3D
	
	# If the material is null, create a new StandardMaterial3D
	if material == null:
		material = StandardMaterial3D.new()
		mesh.surface_set_material(0,material)

	material.albedo_color = new_color
	
func on_block_focused(interactor)->void:
	material_override = outline

func on_block_unfocused(interactor)->void:
	material_override = null

func on_block_interacted(interactor)->void:
	var random_color = Color(randf(), randf(), randf())
	change_mesh_color(random_color)
	


