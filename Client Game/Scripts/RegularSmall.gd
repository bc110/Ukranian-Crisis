extends Area2D

onready var global_vars = get_node("/root/Global")

export var enemy = "RU"

func _on_Area2D_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
		print(global_vars.hits)
		if global_vars.neutriliseUnit:
			if global_vars.neutriliseUnitLeft > 0:
				if global_vars.playerNation == enemy:
					var unit
					if enemy == "UA":
						unit = "RuRe"
					elif enemy == "RU":
						unit = "UaRe"
					get_parent().get_parent().neutriliseUnit(unit)
		elif global_vars.hits > 0:
			if true:
				if global_vars.playerNation == enemy:
					global_vars.hits -=1
					var unit
					if enemy == "UA":
						unit = "RuRe"
						global_vars.ReRuBattle -= 1
						global_vars.ReRuNuBattle += 1
					elif enemy == "RU":
						unit = "UaRe"
						global_vars.ReUaBattle -= 1
						global_vars.ReUaNuBattle += 1
						
					global_vars.territoryAction = {"TerritoryName":global_vars.territoryName,"UnitEffected":unit,"Action":"neutrilize"}
					var moveData = {"MoveType":"TerritoryAction","Action":global_vars.territoryAction}
					Server.SendMove(moveData,get_instance_id())
					get_parent().get_parent().updateUnits()
					print("Netrulized")
					
		elif global_vars.CombatPhase and !global_vars.showBattle:
			if global_vars.turnPlayer:
				if global_vars.CombatPoints > 0:
					if global_vars.playerNation != enemy:
						global_vars.CombatPoints -= 1
						var unit
						if global_vars.playerNation == "UA":
							unit = "UaRe"
						else:
							unit = "RuRe"
						global_vars.territoryAction = {"TerritoryName":global_vars.territoryName,"UnitEffected":unit,"Action":"removed"}
						var moveData = {"MoveType":"TerritoryAction","Action":global_vars.territoryAction}
						Server.SendMove(moveData,get_instance_id())
						global_vars.movingUnit = unit
						
						global_vars.hideTerritory = true
				elif global_vars.battle:
					if $Sprite2.visible:
						$Sprite2.visible = false
						if enemy == "UA":
							global_vars.ReRuBattle -= 1
						else:
							global_vars.ReUaBattle -= 1
					else:
						$Sprite2.visible = true
						if enemy == "UA":
							global_vars.ReRuBattle += 1
						else:
							global_vars.ReUaBattle += 1
func setVis(vis):
	$Sprite2.visible = vis
