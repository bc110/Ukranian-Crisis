extends Sprite

onready var global_vars = get_node("/root/Global")

var playerScore = 26
var enemyScore = 0

var drawText

var tacticalVictoryRU
var tacticalVictoryUA

var smashingVictoryRU
var smashingVictoryUA

func _ready():
	drawText = "The crisis has stabilized for now, possibly in some\n"
	drawText += "form of temporary ceasefire, though the basic\n"
	drawText +="issues are still not resolved. The advantage will\n"
	drawText +="be to the country with more points\n"
	drawText +="should it resume."
	
	tacticalVictoryRU = "Russia will continue to be the primary\n"
	tacticalVictoryRU += "influence in Ukraine’s decision calculus.\n"
	
	tacticalVictoryUA = "Ukraine, with the firm support of the Western \n"
	tacticalVictoryUA +=" world and international organizations, has \n"
	tacticalVictoryUA +="successfully stood off the Russian aggression  \n"
	tacticalVictoryUA +="for now. The Russian Federation’s economy and \n"
	tacticalVictoryUA +="international standing have been damaged.\n"
	
	smashingVictoryRU = "Russia now politically and economically, if\n"
	smashingVictoryRU += "not militarily, dominates the government of what\n"
	smashingVictoryRU += "is left of Ukraine, and has evaded most of the \n"
	smashingVictoryRU += "damaging diplomatic and economic repercussions."
	
	smashingVictoryUA = "Ukraine has managed to survive with its government\n "
	smashingVictoryUA +=" and territory intact, though likely owing many\n"
	smashingVictoryUA +="favours and concessions in return for the material\n"
	smashingVictoryUA +=" and diplomatic support of Western Europe and the \n"
	smashingVictoryUA += "United States. President Putin, smarting from this \n"
	smashingVictoryUA += "defeat, is undeterred and resolves to use it as an \n"
	smashingVictoryUA +="example of anti-Russian conspiracy, to stoke \n"
	smashingVictoryUA +="further nationalist feeling at home."
	
func _process(_delta):
	if global_vars.gameOver:
		visible = true
		if playerScore > enemyScore:
			$Label2.text = "You Win"
		else:
			$Label2.text = "You Lose"
		calculateScore()
		getEndText()
	else:
		visible = false

func calculateScore():
	playerScore = global_vars.playerPrestege
	
	if global_vars.useTerritoryScores:
		playerScore = round(global_vars.playerPrestege/2)+global_vars.playerTerritoryScore
		
	enemyScore = global_vars.enemyPrestege
	
	if global_vars.useTerritoryScores:
		enemyScore = round(global_vars.enemyPrestege/2)+global_vars.enemyTerritoryScore
	
func getEndText():
	if global_vars.playerNation == "UA":
		if (playerScore - enemyScore) >= 26: 
			$Label3.text = smashingVictoryUA
			$Label2.text = "Smashing Victory"
		elif (playerScore - enemyScore) >= 11: 
			$Label3.text = tacticalVictoryUA
			$Label2.text = "Tactical Victory"
		elif (playerScore - enemyScore) >= -10: 
			$Label3.text = drawText
			$Label2.text = "Draw"
		elif (playerScore - enemyScore) >= -25: 
			$Label3.text = tacticalVictoryRU
			$Label2.text = "Tactical Loss"
		else:
			$Label3.text = smashingVictoryRU
			$Label2.text = "Smashing Loss"
		
	if global_vars.playerNation == "RU":
		if (playerScore - enemyScore) >= 26: 
			$Label3.text = smashingVictoryRU
			$Label2.text = "Smashing Victory"
		elif (playerScore - enemyScore) >= 11: 
			$Label3.text = tacticalVictoryRU
			$Label2.text = "Tactical Victory"
		elif (playerScore - enemyScore) >= -10: 
			$Label3.text = drawText
			$Label2.text = "Draw"
		elif (playerScore - enemyScore) >= -25: 
			$Label3.text = tacticalVictoryUA
			$Label2.text = "Tactical Loss"
		else: 
			$Label3.text = smashingVictoryUA
			$Label2.text = "Smashing Loss"
