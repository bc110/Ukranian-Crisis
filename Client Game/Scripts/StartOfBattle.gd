extends Sprite

onready var global_vars = get_node("/root/Global")

var totalSegments = 0

func _process(_delta):
	if global_vars.CombatStartScreen:
		if !visible:
			visible = true
			if totalSegments == 0:
				totalSegments = global_vars.OperationalSegments
				if totalSegments == 1:
					$CardChoice.text = "As the higest card used was a minor card \nthis phase shall occur 1 time"
				if totalSegments == 2:
					$CardChoice.text = "As the higest card used was a moderate card \nthis phase shall occur 2 times"
				if totalSegments == 3:
					$CardChoice.text = "As the higest card used was a major card \nthis phase shall occur 3 times"
			global_vars.rolled = false
			$Button.visible = false
			$ResourcePoints.visible = false
	else:
		visible = false
		
	$Button2.visible = (!global_vars.rolled and global_vars.turnPlayer)
	$Waiting.visible = (!global_vars.rolled and !global_vars.turnPlayer)
	$ResourcePoints.text = "You rolled "+str(global_vars.playerMilScore)+" resource points \nso may move "+str(global_vars.playerMilScore)+" units"
		
	# Update Labels
	$Title.text = "Combat Millitary Phase "+str((totalSegments+1) - global_vars.OperationalSegments)+"/"+str(totalSegments)

func _on_Button2_pressed():
	$Button2.visible = false
	$Button.visible = true
	global_vars.rolling = true
	$ResourcePoints.visible = true
	
func _on_Button_pressed():
	if global_vars.OperationalSegments == 1:
		totalSegments = 0
	global_vars.CombatStartScreen = false
