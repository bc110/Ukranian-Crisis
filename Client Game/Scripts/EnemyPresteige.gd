extends Label

onready var global_vars = get_node("/root/Global")

func _process(_delta):
	text = "Prestige : "+str(global_vars.enemyPrestege)
