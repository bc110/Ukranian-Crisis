extends Area2D

onready var global_vars = get_node("/root/Global")

export var enemy = "RU"

func setVis(vis):
	$Sprite2.visible = vis

func _on_Area2D_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
		if global_vars.hits > 0:
			if enemy == global_vars.playerNation:
				if global_vars.playerNation == enemy:
					global_vars.hits -= 1
					global_vars.killUnit = true
					var unit
					if enemy == "UA":
						unit = "RuNuIr"
						global_vars.IrRuNuBattle -= 1
					elif enemy == "RU":
						unit = "UaNuIr"
						global_vars.IrUaNuBattle -= 1
					global_vars.territoryAction = {"TerritoryName":global_vars.territoryName,"UnitEffected":unit,"Action":"removed"}
					var moveData = {"MoveType":"TerritoryAction","Action":global_vars.territoryAction}
					Server.SendMove(moveData,get_instance_id())
					get_parent().get_parent().updateUnits()
		elif global_vars.battle:
			if enemy == global_vars.playerNation:
				if $Sprite2.visible:
					$Sprite2.visible = false
					if enemy == "UA":
						global_vars.IrRuNuBattle -= 1
					else:
						global_vars.IrUaNuBattle -= 1
				else:
					$Sprite2.visible = true
					if enemy == "UA":
						global_vars.IrRuNuBattle += 1
					else:
						global_vars.IrUaNuBattle += 1
