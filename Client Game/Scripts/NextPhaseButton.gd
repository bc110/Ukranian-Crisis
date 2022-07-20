extends Sprite


onready var global_vars = get_node("/root/Global")

func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
		if get_rect().has_point(to_local(event.position)):
			if global_vars.phase == 4:
				if global_vars.turnPlayer:
					global_vars.turnPlayer = false
					if !global_vars.waitingOnData:
						global_vars.nextPhase()
					else:
						global_vars.waitingOnData = false
					var moveData = {"MoveType":"EndInformation"}		
					Server.SendMove(moveData,get_instance_id())
					
				
			elif !global_vars.showWaiting:
				global_vars.nextPhase()


