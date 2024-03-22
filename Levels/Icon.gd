extends Sprite3D

var coins = 5
var player_name = "bot_boi"
var hearts = 3.5
const SPEED = 2
var x = coins
# Called when the node enters the scene tree for the first time.
func _ready():
	minion()
	print(add_these_numbers(5,6))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	check_input()

func minion():
	print("banana")

func add_these_numbers(x,y):
	var sum = x + y
	return sum

func check_input():
	if Input.is_action_pressed("ui_left"):
		rotate_y(-0.03)
	elif Input.is_action_pressed("ui_right"):
		rotate_y(0.03)
