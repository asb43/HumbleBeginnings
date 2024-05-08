class_name HumbleBegginingPlayerHudManager
extends Control

## Reference to the Node that has the player.gd script.
@export var player: Node
## Used to reset icons etc, useful to have.
@export var empty_texture : Texture2D
## The hint icon that displays when no other icon is passed.
@export var default_hint_icon : Texture2D

## PackedScene/Prefab for Interaction Prompts
@export var prompt_component : PackedScene

## PackedScene/Prefab for Hints
@export var hint_component : PackedScene

## This sets how far away from the player dropped items appear. 0 = items appear on the tip of the player interaction raycast. Negative values mean closer, positive values mean further away that this.
@export var item_drop_distance_offset : float = -1

## Reference to PackedScene that gets instantiated for each player attribute.
@export var ui_attribute_prefab : PackedScene

var hurt_tween : Tween
var is_inventory_open : bool = false
var device_id : int = -1
var interaction_texture : Texture2D

func setup_player(new_player : Node):
	player = new_player
	_setup_player()

func _setup_player():
	pass
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
