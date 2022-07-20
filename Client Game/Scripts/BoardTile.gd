extends Sprite

onready var global_vars = get_node("/root/Global")

export var type = "Minor"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
		if get_rect().has_point(to_local(event.position)):
			if global_vars.pickCards():
				global_vars.minorSelected(type)
				get_parent().remove_child(self)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
