extends Area3D

const ROT_SPEED = 2 # rotates at the speed of 2 in degrees

# Called when the node enters the scene tree for the first time.
func _ready():
	if not is_connected("body_entered", Callable(self, "_on_body_entered")):
		connect("body_entered", Callable(self, "_on_body_entered"))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	rotate_y(deg_to_rad(ROT_SPEED))
		

func _on_body_entered(body):
	if body.is_in_group("Player"):
		var interactor = body.get_node("CharacterBody3DInteractor")
		if interactor:
			interactor.handle_coin_interact(self)
