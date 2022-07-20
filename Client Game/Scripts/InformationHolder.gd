extends Sprite

onready var global_vars = get_node("/root/Global")

var reducing = false
var reduce1 = 0
var reduce2 = 0

var smallValue = 0
var largeValue = 0

func _process(_delta):
	if global_vars.showInformation:
		if !visible:
			visible = true
			$NeutralizScreen.get_node("RollNeutralize").visible = true
			$NeutralizScreen.get_node("1").visible = false
			$NeutralizScreen.get_node("CloseNeutralize").visible = false
			$NeutralizScreen.visible = false
			if global_vars.millitaryTurn:
				$IncreasePresteige.visible = false
				$ReducePresteige.visible = false
			else:
				$IncreasePresteige.visible = true
				$ReducePresteige.visible = true
	else:
		visible = false
	
	$IncreaseScreen.get_node("1").text = "You rolled "+str(global_vars.playerInfScore)+" on the effort chat \n and gained "+str(global_vars.playerInfScore)+" presteige"
	$NeutralizScreen.get_node("1").text = "You rolled "+str(global_vars.playerInfScore)+" on the effort chat \n to neutrilize units roll less then "+str(global_vars.playerInfScore)+"\n on attempt to neutrilize"
	
	if reduce1 == -1:
		if global_vars.playerInfScore != null:
			$ReduceScreen.get_node("Reduce1").text = "You rolled "+str(global_vars.playerInfScore)+" on the effort chat"
			reduce1 = global_vars.playerInfScore
			global_vars.playerInfScore = null
			checkIfBoth()
			
	if reduce2 == -1:
		if global_vars.playerInfScore != null:
			$ReduceScreen.get_node("Reduce2").text = "You rolled "+str(global_vars.playerInfScore)+" on the effort chat"
			reduce2 = global_vars.playerInfScore
			global_vars.playerInfScore = null
			checkIfBoth()
	
func hideButtons():
	$IncreasePresteige.visible = false
	$Button.visible = false
	$ReducePresteige.visible = false

func resetVisability():
	#Buttons
	$IncreasePresteige.visible = true
	$Button.visible = true
	$ReducePresteige.visible = true
	
	#Increase
	$IncreaseScreen.visible = false
	$IncreaseScreen.get_node("1").visible = false
	$IncreaseScreen.get_node("Roll").visible = true
	$IncreaseScreen.get_node("CloseIncrease").visible = false
	
	#Reduce
	$ReduceScreen.visible = false
	$ReduceScreen.get_node("Reduce1").visible = false
	$ReduceScreen.get_node("Reduce2").visible = false
	$ReduceScreen.get_node("Reduce3").visible = false
	
	$ReduceScreen.get_node("RollReduce1").visible = true
	$ReduceScreen.get_node("RollReduce2").visible = true
	
	$ReduceScreen.get_node("CloseReduce").visible = false

func checkIfBoth():
	if (reduce1 > 0) and (reduce2 > 0):
		if reduce1 > reduce2:
			largeValue = reduce1
			smallValue = reduce2
		else:
			largeValue = reduce2
			smallValue = reduce1
		$ReduceScreen.get_node("Reduce3").visible = true
		$ReduceScreen.get_node("CloseReduce").visible = true
		$ReduceScreen.get_node("Reduce3").text = "You lose "+str(smallValue)+" presteige \n Your opponant losses "+str(largeValue)+" presteige"
	
func _on_IncreasePresteige_pressed():
	if global_vars.turnPlayer:
		global_vars.message("Selected increase presteige","Action")
		hideButtons()
		$IncreaseScreen.visible = true


func _on_ReducePresteige_pressed():
	if global_vars.turnPlayer:
		global_vars.message("Selected reduce presteige","Action")
		hideButtons()
		$ReduceScreen.visible = true
		reducing = true

func _on_Button_pressed():
	if global_vars.turnPlayer:
		global_vars.message("Selected neutrilise","Action")
		hideButtons()
		$NeutralizScreen.visible = true

func _on_Roll_pressed():
	global_vars.rolling = true
	$IncreaseScreen.get_node("Roll").visible = false
	$IncreaseScreen.get_node("1").visible = true
	$IncreaseScreen.get_node("CloseIncrease").visible = true

func _on_RollReduce1_pressed():
	global_vars.playerInfScore = null
	global_vars.rolling = true
	$ReduceScreen.get_node("RollReduce1").visible = false
	$ReduceScreen.get_node("Reduce1").visible = true
	reduce1 = -1

func _on_RollReduce2_pressed():
	global_vars.playerInfScore = null
	global_vars.rolling = true
	$ReduceScreen.get_node("RollReduce2").visible = false
	$ReduceScreen.get_node("Reduce2").visible = true
	reduce2 = -1

func _on_CloseIncrease_pressed():
	resetVisability()
	global_vars.rolled = false
	global_vars.turnPlayer = false
		
	var value = global_vars.playerInfScore
	global_vars.playerPrestege += value
	global_vars.message("Increased presteige by "+ str(value),"Action")
	
	var moveData = {"MoveType":"IncreasePrestege","value":value}
	Server.SendMove(moveData,get_instance_id())
	
	if !global_vars.waitingOnData:
		global_vars.nextPhase()
	else:
		global_vars.waitingOnData = false
		

func _on_CloseReduce_pressed():
	resetVisability()
	global_vars.rolled = false
	global_vars.turnPlayer = false
		
	global_vars.playerPrestege -= smallValue
	global_vars.enemyPrestege -= largeValue
	
	global_vars.message("Reduced there presteige by "+ str(smallValue) +" and reduced enemy presteige by "+str(largeValue),"Action")
	
	var moveData = {"MoveType":"ReducePrestege","playerValue":smallValue,"enemyValue":largeValue}
	Server.SendMove(moveData,get_instance_id())
		
	if !global_vars.waitingOnData:
		global_vars.nextPhase()
	else:
		global_vars.waitingOnData = false


func _on_RollNeutralize_pressed():
	global_vars.rolling = true
	$NeutralizScreen.get_node("RollNeutralize").visible = false
	$NeutralizScreen.get_node("1").visible = true
	$NeutralizScreen.get_node("CloseNeutralize").visible = true


func _on_CloseNeutralize_pressed():
	resetVisability()
	global_vars.showInformation = false
	global_vars.showingMap = true
	global_vars.neutriliseUnit = true
	if global_vars.playerInfCard == "Minor":
		global_vars.neutriliseUnitLeft = 1
	elif global_vars.playerInfCard == "Moderate":
		global_vars.neutriliseUnitLeft = 2
	elif global_vars.playerInfCard == "Major":
		global_vars.neutriliseUnitLeft = 3
	
	global_vars.message("Has "+str(global_vars.neutriliseUnitLeft)+" attempts to neutrilise units","Action")
