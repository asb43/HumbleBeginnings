extends Node

const OptionConstants = preload("res://EasyMenus-825d5c0607cc4b3f0af636f4903527518404383c/addons/EasyMenus/Scripts/game_options_constants.gd")
const InputMapUpdater = preload("res://EasyMenus-825d5c0607cc4b3f0af636f4903527518404383c/addons/EasyMenus/Scripts/input_map_updater.gd")

@onready var ControllerEchoInputGenerator = $ControllerEchoInputGenerator
@onready var startup_loader = $StartupLoader

func _ready():
	InputMapUpdater.new()._ready()
