extends Sprite

onready var global_vars = get_node("/root/Global")

func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
		if get_rect().has_point(to_local(event.position)):
			if global_vars.showPointSelector:
				if global_vars.MinTotalPoints <= (global_vars.PPToUse + global_vars.RPToUse):
					global_vars.attemptMove()
