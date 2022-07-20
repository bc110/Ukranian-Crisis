extends Control

onready var global_vars = get_node("/root/Global")

func _process(_delta):
	if  global_vars.showPointSelector:
		if !visible:
			visible = true
	updateText()
	
var rolled = false


func _on_Button_pressed():
	if global_vars.showPointSelector:
		if global_vars.MinTotalPoints <= (global_vars.PPToUse + global_vars.RPToUse):
			$Button.visible = false
			$Container.visible = false
			showDice()
			rollDice()
			
			global_vars.message("Spends "+str(global_vars.PPToUse)+" Presteige and "+str(global_vars.RPToUse)+" Resource points to attempt to move "+global_vars.selectedToken,"Action")
			
			var delay = ($Die1.rolls+1)*$Die1.delay+0.6
			yield(get_tree().create_timer(delay), "timeout")
			
			var values = [$Die1.value,$Die2.value,$Die3.value]
			global_vars.attemptMove(values)
			$Close.visible = true
			rolled = true

func showDice():
	if global_vars.selectedTokenRank >= 1:$Die1.visible = true
	if global_vars.selectedTokenRank >= 2:$Die2.visible = true
	if global_vars.selectedTokenRank >= 3:$Die3.visible = true

func rollDice():
	if global_vars.selectedTokenRank >= 1:$Die1.rollDie()
	if global_vars.selectedTokenRank >= 2:$Die2.rollDie()
	if global_vars.selectedTokenRank >= 3:$Die3.rollDie()

func updateText():
	if !rolled:$Label.text = "Minimum points required to attempt a move is "+str(global_vars.MinTotalPoints)+" amount selcted is "+str(global_vars.PPToUse + global_vars.RPToUse)+"\n To successfully move. roll "+str(global_vars.selectedTokenRank)+"d6, if the total is less then\n or equal to "+str(global_vars.PPToUse + global_vars.RPToUse)+ " country is moved"
	else:$Label.text = "Dice Rolled"

func _on_Close_pressed():
	$Die1.visible = false
	$Die2.visible = false
	$Die3.visible = false
	$Button.visible = true
	$Close.visible = false
	
	$Container.visible = true
	visible = false
	rolled = false
