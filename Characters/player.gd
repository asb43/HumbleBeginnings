class_name Bot_boi
extends CharacterBody3D



@onready var camera = $Camera_Controller
@onready var animation_player = $AnimationPlayer


## Reference to Pause menu node
@export var pause_menu : NodePath
## Refereence to Player HUD node
@export var player_hud : NodePath
# Used for handling input when UI is open/displayed
var is_showing_ui : bool

const SPEED = 5.0
const JUMP_VELOCITY = 4.5
var jumps = 0
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

@export var sens_horizontal = .5
@export var sens_vertical = .5

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(deg_to_rad(-event.relative.x*sens_horizontal))
		camera.rotate_x(deg_to_rad(-event.relative.y* sens_vertical))

func _physics_process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

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
