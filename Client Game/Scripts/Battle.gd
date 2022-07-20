extends Button

onready var global_vars = get_node("/root/Global")

func _process(_delta):
	if global_vars.hits > 0:
		visible = false
	elif global_vars.terrioryBattle == false:
		visible = false
	elif global_vars.playerNation == "UA":
		if ((global_vars.IrUaBattle+global_vars.ReUaBattle)>0) and ((global_vars.IrRuBattle+global_vars.IrRuNuBattle+global_vars.ReRuBattle+global_vars.ReRuNuBattle)>0):
			visible = true
		else:
			visible = false
	elif global_vars.playerNation == "RU":
		if ((global_vars.IrRuBattle+global_vars.ReRuBattle)>0) and ((global_vars.IrUaBattle+global_vars.IrUaNuBattle+global_vars.ReUaBattle+global_vars.ReUaNuBattle)>0):
			visible = true
		else:
			visible = false
	else:
		visible = false
