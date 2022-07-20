extends Sprite

onready var global_vars = get_node("/root/Global")

func _process(_delta):
	changeOrder()
	changeColour()

func closeAll():
	$EffortInfo.visible = false
	$TurnInfo.visible = false
	$CeasefireInfo.visible = false
	$OrderInfo.visible = false
	
	$MillitaryInfo.visible = false
	$DiplomaticInfo.visible = false
	$InformationInfo.visible = false

func changeColour():
	$Effort.add_color_override("font_color", Color(1,1,1))
	$TurnType.add_color_override("font_color", Color(1,1,1))
	$Ceasefire.add_color_override("font_color", Color(1,1,1))
	$Order.add_color_override("font_color", Color(1,1,1))
	$Phase1.add_color_override("font_color", Color(1,1,1))
	$Phase2.add_color_override("font_color", Color(1,1,1))
	$Phase3.add_color_override("font_color", Color(1,1,1))
	$EndPhase.add_color_override("font_color", Color(1,1,1))
	
	if global_vars.phase == 1 and !global_vars.showEndCard:$Effort.add_color_override("font_color", Color(0.2,0.7,0.2))
	if global_vars.pickingTurnType:$TurnType.add_color_override("font_color", Color(0.2,0.7,0.2))
	if global_vars.showCeasefire:$Ceasefire.add_color_override("font_color", Color(0.2,0.7,0.2))
	if global_vars.pickingOrder:$Order.add_color_override("font_color", Color(0.2,0.7,0.2))
	if global_vars.turnIndex == 1:$Phase1.add_color_override("font_color", Color(0.2,0.7,0.2))
	if global_vars.turnIndex == 2:$Phase2.add_color_override("font_color", Color(0.2,0.7,0.2))
	if global_vars.turnIndex == 3:$Phase3.add_color_override("font_color", Color(0.2,0.7,0.2))
	if global_vars.showEndCard:$EndPhase.add_color_override("font_color", Color(0.2,0.7,0.2))

func changeOrder():
	if global_vars.turnOrder == null:
		$Phase1.text = "Diplomatic Phase (Postion may change)"
		$Phase2.text = "Millitary Phase (Postion may change)"
		$Phase3.text = "Information Phase (Postion may change)"
	else:
		if global_vars.turnOrder[0] == 2:$Phase1.text = "Diplomatic Phase"
		elif global_vars.turnOrder[0] == 3:$Phase1.text = "Millitary Phase"
		elif global_vars.turnOrder[0] == 4:$Phase1.text = "Information Phase"
		
		if global_vars.turnOrder[1] == 2:$Phase2.text = "Diplomatic Phase"
		elif global_vars.turnOrder[1] == 3:$Phase2.text = "Millitary Phase"
		elif global_vars.turnOrder[1] == 4:$Phase2.text = "Information Phase"
		
		if global_vars.turnOrder[2] == 2:$Phase3.text = "Diplomatic Phase"
		elif global_vars.turnOrder[2] == 3:$Phase3.text = "Millitary Phase"
		elif global_vars.turnOrder[2] == 4:$Phase3.text = "Information Phase"

func _on_Effort_pressed():
	closeAll()
	$EffortInfo.visible = true

func _on_closeInfoBox_pressed():
	closeAll()

func _on_TurnType_pressed():
	closeAll()
	$TurnInfo.visible = true

func _on_Ceasefire_pressed():
	closeAll()
	$CeasefireInfo.visible = true


func _on_Order_pressed():
	closeAll()
	$OrderInfo.visible = true


func _on_Phase1_pressed():
	closeAll()
	if global_vars.turnOrder == null:$DiplomaticInfo.visible = true
	elif global_vars.turnOrder[0] == 3:$MillitaryInfo.visible = true
	elif global_vars.turnOrder[0] == 2:$DiplomaticInfo.visible = true
	elif global_vars.turnOrder[0] == 4:$InformationInfo.visible = true


func _on_Phase2_pressed():
	closeAll()
	if global_vars.turnOrder == null:$MillitaryInfo.visible = true
	elif global_vars.turnOrder[1] == 3:$MillitaryInfo.visible = true
	elif global_vars.turnOrder[1] == 2:$DiplomaticInfo.visible = true
	elif global_vars.turnOrder[1] == 4:$InformationInfo.visible = true


func _on_Phase3_pressed():
	closeAll()
	if global_vars.turnOrder == null:$InformationInfo.visible = true
	elif global_vars.turnOrder[2] == 3:$MillitaryInfo.visible = true
	elif global_vars.turnOrder[2] == 2:$DiplomaticInfo.visible = true
	elif global_vars.turnOrder[2] == 4:$InformationInfo.visible = true
