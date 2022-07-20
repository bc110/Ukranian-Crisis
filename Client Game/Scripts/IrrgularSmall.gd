extends Area2D

onready var global_vars = get_node("/root/Global")

export var enemy = "RU"

signal unit_hit

func _on_Area2D_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
		if global_vars.neutriliseUnit:
			if global_vars.neutriliseUnitLeft > 0:
				if global_vars.playerNation == enemy:
					var unit
					if enemy == "UA":
						unit = "RuIr"
					elif enemy == "RU":
						unit = "UaIr"
					get_parent().get_parent().neutriliseUnit(unit)
					"""
					global_vars.neutriliseUnitLeft -= 1
					var rolledNum = (randi() % 6)+1
					print("Rolled : "+str(rolledNum))
					if rolledNum <= global_vars.playerInfScore:
						var unit
						if enemy == "UA":
							unit = "RuIr"
						elif enemy == "RU":
							unit = "UaIr"
						global_vars.territoryAction = {"TerritoryName":global_vars.territoryName,"UnitEffected":unit,"Action":"neutrilize"}
						var moveData = {"MoveType":"TerritoryAction","Action":global_vars.territoryAction}
						Server.SendMove(moveData,get_instance_id())
						print("Netrulized")
					else:
						print("Failed to Netrulized")
					"""
		elif global_vars.hits > 0:
			if true:
				if global_vars.playerNation == enemy:
					global_vars.hits -=1
					var unit
					if enemy == "UA":
						unit = "RuIr"
						global_vars.IrRuBattle -= 1
						global_vars.IrRuNuBattle += 1
					elif enemy == "RU":
						unit = "UaIr"
						global_vars.IrUaBattle -= 1
						global_vars.IrUaNuBattle += 1
						
					global_vars.territoryAction = {"TerritoryName":global_vars.territoryName,"UnitEffected":unit,"Action":"neutrilize"}
					var moveData = {"MoveType":"TerritoryAction","Action":global_vars.territoryAction}
					Server.SendMove(moveData,get_instance_id())
					get_parent().get_parent().updateUnits()
					print("Netrulized")
					
		elif global_vars.CombatPhase and !global_vars.showBattle:
			if global_vars.turnPlayer:
				if false:#global_vars.CombatPoints > 0:
					if global_vars.playerNation != enemy:
						global_vars.CombatPoints -= 1
						print("move")
						var unit
						if global_vars.playerNation == "UA":
							unit = "UaIr"
						else:
							unit = "RuIr"
						print("Move2")
						global_vars.movingUnit = unit
						global_vars.territoryAction = {"TerritoryName":global_vars.territoryName,"UnitEffected":unit,"Action":"removed"}
						print(global_vars.territoryAction)
						var moveData = {"MoveType":"TerritoryAction","Action":global_vars.territoryAction}
						Server.SendMove(moveData,get_instance_id())
						
						global_vars.hideTerritory = true
				elif global_vars.battle:
					if $Sprite2.visible:
						$Sprite2.visible = false
						if enemy == "UA":
							global_vars.IrRuBattle -= 1
						else:
							global_vars.IrUaBattle -= 1
					else:
						$Sprite2.visible = true
						if enemy == "UA":
							global_vars.IrRuBattle += 1
						else:
							global_vars.IrUaBattle += 1
func setVis(vis):
	$Sprite2.visible = vis

func _on_unit_hit():
	print("huh3")
