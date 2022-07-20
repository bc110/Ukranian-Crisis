extends Label

onready var global_vars = get_node("/root/Global")

func _process(_delta):
	text = "Turn " + str(global_vars.turn)+"/8"
