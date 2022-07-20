extends Sprite

onready var global_vars = get_node("/root/Global")

var minorChart = preload("res://Sprites/Effort/MinorEffort.PNG")
var moderateChart = preload("res://Sprites/Effort/ModerateEffort.PNG")

var RP = 0
var cardType = null

func _process(_delta):
	if global_vars.rolling:
		if !visible:
			visible = true
			reset()
	else:
		visible = false

func reset():
	$Button.visible = true
	$Die.switchTexture(1)
	$SubTitle2.visible = false
	$Confirm.visible = false
	$"Add Points".visible = false
	getCardType()
	setChart()

func setResourcePoints():
	if global_vars.showCeasefire:
		global_vars.playerDipScore = RP
	if global_vars.phase == 2:
		global_vars.playerDipScore = RP
	if global_vars.phase == 3:
		global_vars.playerMilScore = RP
	if global_vars.phase == 5:
		global_vars.CombatPoints = RP
		global_vars.playerMilScore = RP
	if global_vars.phase == 4:
		global_vars.playerInfScore = RP

func getCardType():
	if global_vars.showCeasefire:
		cardType = global_vars.playerDipCard
	if global_vars.phase == 2:
		cardType = global_vars.playerDipCard
	if global_vars.phase == 3:
		cardType = global_vars.playerMilCard
	if global_vars.phase == 5:
		cardType = global_vars.playerMilCard
	if global_vars.phase == 4:
		cardType = global_vars.playerInfCard

func setChart():
	if cardType == "Minor":
		$Chart.set_texture(minorChart)
	elif cardType == "Moderate":
		$Chart.set_texture(moderateChart)
	elif cardType == "Major":
		setMajor()
func _on_Button_pressed():
	# Rolls die
	$Button.visible = false
	if cardType != "Major":
		$Die.rollDie()
	else:
		$Die1.rollDie()
		$Die2.rollDie()
	var delay = ($Die.rolls+1)*$Die.delay+0.2
	
	# Wait for roll to be over
	yield(get_tree().create_timer(delay), "timeout")
	
	# Calculate RP
	if cardType == "Minor":
		RP = global_vars.minorArray[$Die.value-1]
	elif cardType == "Moderate":
		RP = global_vars.moderateArray[$Die.value-1]
	elif cardType == "Major":
		RP = $Die1.value + $Die2.value
	setResourcePoints()
	
	# Display information
	$SubTitle2.visible = true
	if cardType != "Major":
		$SubTitle2.text = "You rolled a "+str($Die.value)+" and gained "+str(RP)+" resource points!"
		global_vars.message("Rolled a "+str($Die.value)+" and gained "+str(RP)+" resource points!","Action")
	if cardType == "Major":
		$SubTitle2.text = "You rolled a "+str($Die1.value)+" and a "+str($Die2.value)+" and gained "+str(RP)+" resource points!"
		global_vars.message("Rolled a "+str($Die1.value)+" and a "+str($Die2.value)+" and gained "+str(RP)+" resource points!","Action")
	$Confirm.visible = true
	
	if global_vars.playerNation == "UA":
		if global_vars.extraRP > 0:
			$"Add Points".visible = true
			$"Add Points".text = "Add "+str(global_vars.extraRP)+" points"
	"""
	# Send Ceasefire Info
	if global_vars.showCeasefire:
		var moveData = {"MoveType":"Ceasefire","value":RP}
		Server.SendMove(moveData,get_instance_id())
	"""


func _on_Confirm_pressed():
	unsetMajor()
	global_vars.rolled = true
	global_vars.rolling = false
	# Send Ceasefire Info
	if global_vars.showCeasefire:
		var moveData = {"MoveType":"Ceasefire","value":RP}
		Server.SendMove(moveData,get_instance_id())


func setMajor():
	$Die.visible = false
	$Chart.visible = false
	
	$MajorChart.visible = true
	$Die1.visible = true
	$Die2.visible = true
	
func unsetMajor():
	$Die.visible = true
	$Chart.visible = true
	
	$MajorChart.visible = false
	$Die1.visible = false
	$Die2.visible = false


func _on_Add_Points_pressed():
	$"Add Points".visible = false
	RP += global_vars.extraRP
	$SubTitle2.text = "You added your "+str(global_vars.extraRP)+" bonus resource ponts \n for a total of "+str(RP)+" resource ponts"
	setResourcePoints()
	global_vars.extraRP = 0
