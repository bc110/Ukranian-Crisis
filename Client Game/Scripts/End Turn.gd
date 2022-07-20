extends Sprite

onready var global_vars = get_node("/root/Global")

func _process(_delta):
	if global_vars.showEndCard:
		if !visible:
			visible = true
			findPresteige()
			findExtraRP()
	else:
		visible = false

func findPresteige():
	var preCount = 0
	
	if global_vars.USPos >= 2: preCount += global_vars.USValue
	if global_vars.DEPos >= 2: preCount += global_vars.DEValue
	if global_vars.GBPos >= 2: preCount += global_vars.GBValue
	if global_vars.FRPos >= 2: preCount += global_vars.FRValue
	if global_vars.ROPos >= 2: preCount += global_vars.ROValue
	if global_vars.BYPos >= 2: preCount += global_vars.BYValue
	if global_vars.PLPos >= 2: preCount += global_vars.PLValue
	
	$PresteigeGained.text = "Due to nations in the support and intervention zone \n Ukrane gains "+str(preCount)+" prestege"
	
	if global_vars.playerNation == "UA":
		global_vars.playerPrestege += preCount
	else:
		global_vars.enemyPrestege += preCount

func findExtraRP():
	var preCount = 0
	
	if global_vars.USPos >= 3: preCount += global_vars.USValue
	if global_vars.DEPos >= 3: preCount += global_vars.DEValue
	if global_vars.GBPos >= 3: preCount += global_vars.GBValue
	if global_vars.FRPos >= 3: preCount += global_vars.FRValue
	if global_vars.ROPos >= 3: preCount += global_vars.ROValue
	if global_vars.BYPos >= 3: preCount += global_vars.BYValue
	if global_vars.PLPos >= 3: preCount += global_vars.PLValue
	
	$"Resource Points".text = "Due to nations in the intervention zone \n Ukrane gains "+str(preCount)+" extra resource points \n which they can use when rolling for resource points \n once during the next turn"
	
	global_vars.extraRP = preCount

func _on_Close_pressed():
	global_vars.showEndCard = false
	global_vars.turn += 1

