@tool
extends Area3D

## Class used to create interactive objects in 3D space.
class_name Interactable3D

## Emitted when an [Interactor3D] starts looking at object.
signal focused(interactor: Interactor3D)
## Emitted when an [Interactor3D] stops looking at object.
signal unfocused(interactor: Interactor3D)
## Emitted when an [Interactor3D] interacts with an object.
signal interacted(interactor: Interactor3D)
## Emitted when an [Interactable3D] is the closest to the [Interactor3D].
signal closest(interactor: Interactor3D)
## Emitted when an [Interactable3D] is no longer the closest one to the [Interactor3D].
signal not_closest(interactor: Interactor3D)



func _on_interacted(interactor):
	emit_signal("interacted", interactor)


func _on_unfocused(interactor):
	emit_signal("unfocused", interactor)


func _on_focused(interactor):
	emit_signal("focused", interactor)


func _ready():
	var mesh_instance = get_parent().get_node("MeshInstance3D")
	if mesh_instance:
		connect("interacted", Callable(mesh_instance, "on_block_interacted"))
		connect("focused", Callable(mesh_instance, "on_block_focused"))
		connect("unfocused", Callable(mesh_instance, "on_block_unfocused"))
