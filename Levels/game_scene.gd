extends Node

## List of connector nodes. These are used to place the Player in the correct position when they transition to this scene from a different scene. The Node name needs to match the passed string for this to work.
@export var connectors : Array[Node3D]

func move_player_to_connector(connector_name:String):
	for node in connectors:
		if node.get_name() == connector_name:
			print("Connector found, moving player to ", node.get_name())
			var player = get_node ("bot_boi")
			player.global_position = node.global_position
			player.global_rotation = node.global_rotation
			return
	
	print("No connector with name ", connector_name, " found.")
