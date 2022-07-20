extends Label

onready var global_vars = get_node("/root/Global")

func _process(_delta):
	var playerScore = global_vars.playerPrestege
	
	if global_vars.useTerritoryScores:
		playerScore = round(global_vars.playerPrestege/2)+global_vars.playerTerritoryScore
	
	if global_vars.playerNation == "UA":
		text = "Ukraine - Presteige : "+str(global_vars.playerPrestege)+"  Score : "+str(playerScore)
	else:
		text = "Russian - Presteige : "+str(global_vars.playerPrestege)+"  Score : "+str(playerScore)
