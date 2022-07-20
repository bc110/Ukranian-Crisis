extends Label

onready var global_vars = get_node("/root/Global")

func _process(_delta):
	var playerScore = global_vars.enemyPrestege
	
	if global_vars.useTerritoryScores:
		playerScore = round(global_vars.enemyPrestege/2)+global_vars.enemyTerritoryScore
	
	if global_vars.playerNation == "UA":
		text = "Russian - Presteige : "+str(global_vars.enemyPrestege)+"  Score : "+str(playerScore)
	else:
		text = "Ukranian - Presteige : "+str(global_vars.enemyPrestege)+"  Score : "+str(playerScore)
