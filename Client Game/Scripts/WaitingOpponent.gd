extends Sprite

onready var global_vars = get_node("/root/Global")

func _process(_delta):
	if global_vars.pickingOrder:
		if global_vars.playerPrestege < global_vars.enemyPrestege:
			visible = true
		else:
			visible = false
	elif global_vars.showWaiting:
		visible = true
	else:
		visible = false
