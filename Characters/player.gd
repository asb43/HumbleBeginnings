class_name Bot_boi
extends CharacterBody3D



@onready var camera = $Camera_Controller
@onready var animation_player = $AnimationPlayer
@onready var pause_menu_get = $"../PauseMenu"
@onready var coinsLabel = $"../CoinTotal"

var coins = 0

## Reference to Pause menu node
@export var pause_menu : NodePath
## Refereence to Player HUD node
@export var player_hud : NodePath
# Used for handling input when UI is open/displayed
var is_showing_ui : bool
var config = ConfigFile.new()
const SPEED = 5.0
const JUMP_VELOCITY = 4.5
var jumps = 0
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var is_movement_paused : bool = false
@export var MOUSE_SENS : float = 0.25
@export var INVERT_Y_AXIS : bool = false
@export var sens_horizontal = .5
@export var sens_vertical = .5

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	if pause_menu:
		var pause_menu_node = get_node_or_null(pause_menu)
		if pause_menu_node:
			pause_menu_node.resume.connect(_on_pause_menu_resume) # Hookup resume signal from Pause Menu
			pause_menu_node.close_pause_menu() # Making sure pause menu is closed on player scene load
		else:
			print("Pause Menu Node Not Found.")
	else:
		print("Player has no reference to pause menu.")

	coinsLabel.text = "Coins: " + str(coins)

func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(deg_to_rad(-event.relative.x*sens_horizontal))
		camera.rotate_x(deg_to_rad(-event.relative.y* sens_vertical))

	if event.is_action_pressed("menu"):
		_on_pause_movement()
		var pause_menu_node = get_node_or_null(pause_menu)
		if pause_menu_node:
			pause_menu_node.open_pause_menu()

func _on_pause_movement():
	if !is_movement_paused:
		is_movement_paused = true
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _on_resume_movement():
	if is_movement_paused:
		is_movement_paused = false
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _reload_options():
	var err = config.load(OptionsConstants.config_file_name)
	if err == 0:
		print("Player.gd: Options reloaded.")
		MOUSE_SENS = config.get_value(OptionsConstants.section_name, OptionsConstants.mouse_sens_key, 0.25)
		INVERT_Y_AXIS = config.get_value(OptionsConstants.section_name, OptionsConstants.invert_vertical_axis_key, true)

func _on_pause_menu_resume():
	_reload_options()
	_on_resume_movement()

func _physics_process(delta):

	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	if is_on_floor():
		jumps = 0

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and (is_on_floor() or jumps < 1):
		velocity.y = JUMP_VELOCITY
		if not is_on_floor():
			jumps+=1

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var direction = (global_transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
func increment_coin_count():
	coins += 1
	coinsLabel.text = "Coins: " + str(coins)
