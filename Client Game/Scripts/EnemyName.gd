extends Label

onready var global_vars = get_node("/root/Global")

func _process(_delta):
	if (global_vars.playerNation != "UA"):
		text = "Ukraine (enemy)"
	else:
		text = "Russia (enemy)"
