extends Sprite

onready var global_vars = get_node("/root/Global")

var checked = false

func _process(_delta):
	visible = global_vars.showCeasefire
	$PlayersRolls.text = "You rolled and got "+str(global_vars.playerDipScore)+" resource points!"
	
	if global_vars.enemyCeasefireValue > 0:
		$OpponantRolls.text = "Your opponant rolled and got "+str(global_vars.enemyCeasefireValue)+" resource points!"
	
	checkBoth()
	
	if global_vars.ceaseCount == 2: endCease()


func _on_Button2_pressed():
	$Button2.visible = false
	$PlayersRolls.visible = true
	global_vars.rolling = true

func checkBoth():
	if global_vars.playerDipScore != null:
		if !checked:
			if (global_vars.playerDipScore > 0) and (global_vars.enemyCeasefireValue > 0):
				checked = true
				var enemyName = "enemy"
				var playerName = "player"
				
				if global_vars.playerNation == "UA":
					enemyName = "Russia (enemy)"
					playerName = "Ukraine (you)"
				else:
					enemyName = "Ukraine (enemy)"
					playerName = "Russia (you)"
				
				var turnName = "no"
				
				if global_vars.playerDipScore > global_vars.enemyCeasefireValue:
					if global_vars.millitaryTurn:
						turnName = "combat"
						global_vars.useTerritoryScores = true
					else:
						turnName = "strategic"
					$Result.text = playerName + " got more resource points and will get there \n way so this turn will be a "+turnName+" turn"
				
				if global_vars.playerDipScore < global_vars.enemyCeasefireValue:
					global_vars.millitaryTurn = !global_vars.millitaryTurn
					if global_vars.millitaryTurn:
						turnName = "combat"
						global_vars.useTerritoryScores = true
					else:
						turnName = "strategic"
					$Result.text = enemyName + " got more resource points and will get there \n way so this turn will be a "+turnName+" turn"
				
				if global_vars.playerDipScore == global_vars.enemyCeasefireValue:
					if global_vars.playerNation == "UA":
						global_vars.millitaryTurn = !global_vars.millitaryTurn
						if global_vars.millitaryTurn:
							turnName = "combat"
							global_vars.useTerritoryScores = true
						else:
							turnName = "strategic"
						$Result.text = "Its a tie so "+enemyName+" will get there \n way so this turn will be a "+turnName+" turn"
					else:
						if global_vars.millitaryTurn:
							turnName = "combat"
							global_vars.useTerritoryScores = true
						else:
							turnName = "strategic"
						$Result.text = "Its a tie so "+playerName+" will get there \n way so this turn will be a "+turnName+" turn"					
				
				$Result.visible = true
				$Button.visible = true


func _on_Button_pressed():
	global_vars.ceaseCount += 1
	$Button.visible = false
	var moveData = {"MoveType":"CeaseClose"}
	Server.SendMove(moveData,get_instance_id())
	#endCease()
	
func endCease():
	global_vars.showCeasefire = false
	$ResourcePoints.visible = false
	$PlayersRolls.visible = false
	$OpponantRolls.text = "Opponant is rolling...."
	$Result.visible = false
	$Button.visible = false
	$Button2.visible = true
	global_vars.pickingOrder = true
	checked = false
	global_vars.enemyCeasefireValue = 0
	global_vars.ceaseCount = 0
