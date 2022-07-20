extends Button

onready var global_vars = get_node("/root/Global")

func _process(_delta):
	if global_vars.hits > 0:
		visible = false
	else:
		visible = true
