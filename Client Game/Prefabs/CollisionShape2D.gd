extends CollisionShape2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	print("hi")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _input_event(viewport, event, shape_idx):
	print("clicked???")
	if event is InputEventMouseButton:
		print("clicked?")
		if event.button_index == BUTTON_LEFT and event.pressed:
			print("clicked")
