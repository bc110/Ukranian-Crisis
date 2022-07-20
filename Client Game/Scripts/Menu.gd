extends Control

onready var global_vars = get_node("/root/Global")

func _process(_delta):
	nextButtonUpdate()

func _on_NextTurn_pressed():
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


func _on_ToggleMap_pressed():
	if global_vars.phase == 3:
		if global_vars.showMillitary == true:
			if global_vars.unitSelected == null:
				if global_vars.showingMap == false:
					global_vars.showMillitary = false
					global_vars.showingMap = true
		else:
			if global_vars.unitSelected == null:
				global_vars.showMillitary = true
				global_vars.showingMap = false


func _on_PhaseInfo_pressed():
	global_vars.showingMap = false
	$Info.visible = true


func _on_Close_pressed():
	global_vars.showingMap = true
	$Info.visible = false
	$Info.closeAll()
	
func nextButtonUpdate():
	if global_vars.phase == 5:
		$NextTurn.text = "Start Battles"
	else:
		$NextTurn.text = "Next Phase"
