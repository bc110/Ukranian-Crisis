extends Sprite

onready var global_vars = get_node("/root/Global")

func _ready(): pass

func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
		if get_rect().has_point(to_local(event.position)):
			if global_vars.playerMilScore == null:
				global_vars.nowPickingCards("Millitary")
				global_vars.showHolder()
