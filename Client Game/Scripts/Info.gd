extends Label

onready var global_vars = get_node("/root/Global")

func _process(_delta):
	if global_vars.neutriliseUnit:
		if global_vars.neutriliseUnitLeft > 0:
			text = "You may neutrilize "+str(global_vars.neutriliseUnitLeft)+" more units!"
		else:
			text = "Please countinue..."
	elif global_vars.CombatPhase:
		if global_vars.turnPlayer:
			if global_vars.hits > 0:
				text = "Apply hits to enemy, hits remaing : "+str(global_vars.hits)
			else:
				if global_vars.CombatPoints > 0:
					text = "You have "+str(global_vars.CombatPoints)+" to spend!"
				elif global_vars.battle:
					text = "Pick a territory to begin Battle!"
				else:
					text = "Please countinue..."
		else:
			text = "Opponants turn..."
			
	else:
		text = ""
	
	text = str(global_vars.playerMilScore)
