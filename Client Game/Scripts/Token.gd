extends Sprite

onready var global_vars = get_node("/root/Global")

export var tokenName := "US"
var move = false




# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
		if get_rect().has_point(to_local(event.position)):
			if global_vars.showDiplomatic:
				if global_vars.rolled:
					move = true
					global_vars.tokenSelected(tokenName)
