extends Label

onready var global_vars = get_node("/root/Global")

func _process(_delta):
	var playerScore = global_vars.enemyPrestege
	
	if global_vars.useTerritoryScores:
		playerScore = round(global_vars.enemyPrestege/2)+global_vars.enemyTerritoryScore
		
	text = "Score : "+str(playerScore)
