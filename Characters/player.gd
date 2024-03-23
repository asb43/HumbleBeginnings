extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5
var jumps = 0
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var pitch_input := 0.0
var twist_input := 0.0
var mouse_sensitivity := 0.001
@onready var twist_pivot := $Camera_Controller
@onready var pitch_pivot := $Camera_Controller/Camera_Target

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	twist_pivot.rotate_y(twist_input)
	pitch_pivot.rotate_x(pitch_input)
	pitch_pivot.rotation.x = clamp(
		pitch_pivot.rotation.x,deg_to_rad(-30),deg_to_rad(30))
	twist_input = 0.0
	pitch_input = 0.0

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
	var direction = (twist_pivot.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			twist_input = - event.relative.x * mouse_sensitivity
			pitch_input = - event.relative.y * mouse_sensitivity
	
	
	
	
