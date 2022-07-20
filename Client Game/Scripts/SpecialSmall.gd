extends Area2D

onready var global_vars = get_node("/root/Global")

export var enemy = "RU"

func _on_Area2D_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:					
		if global_vars.CombatPhase and !global_vars.showBattle:
			if global_vars.turnPlayer:
				if global_vars.CombatPoints > 0:
					if global_vars.playerNation != enemy:
						global_vars.CombatPoints -= 1
						var unit = "Special"
						global_vars.territoryAction = {"TerritoryName":global_vars.territoryName,"UnitEffected":unit,"Action":"removed"}
						var moveData = {"MoveType":"TerritoryAction","Action":global_vars.territoryAction}
						Server.SendMove(moveData,get_instance_id())
						global_vars.movingUnit = unit
						
						global_vars.hideTerritory = true
func setVis(vis):
	$Sprite2.visible = vis
