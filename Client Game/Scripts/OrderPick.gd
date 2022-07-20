extends Sprite

onready var global_vars = get_node("/root/Global")

var selected = 0
var selection = []

var millitarySelectionOrder = null
var diplomaticSelectionOrder = null
var informationSelectionOrder = null

func _process(_delta):
	if global_vars.pickingOrder:
		if global_vars.playerPrestege > global_vars.enemyPrestege:
			if !visible:
				visible = true
				millitarySelectionOrder = null
				diplomaticSelectionOrder = null
				informationSelectionOrder = null
				selected = 0
				selection = []
				$MillitaryLable.text = ""
				$DiplomaticLable.text = ""
				$InformationLable.text = ""
				
				if global_vars.millitaryTurn:
					$Diplomatic.visible = false
				else:
					$Diplomatic.visible = true
	else:
		visible = false

func _on_MillitaryArea_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
		if millitarySelectionOrder == null:
			millitarySelectionOrder = selected+1
			selected+=1
			$MillitaryLable.text = String(millitarySelectionOrder)
			if selected == 3 or (selected == 2 and global_vars.millitaryTurn):
				createSelection()
		else:
			global_vars.turnOrder = null
			#Update Others
			if diplomaticSelectionOrder != null:
				if diplomaticSelectionOrder > millitarySelectionOrder:
					diplomaticSelectionOrder -= 1
					$DiplomaticLable.text = String(diplomaticSelectionOrder)
					
			if informationSelectionOrder != null:
				if informationSelectionOrder > millitarySelectionOrder:
					informationSelectionOrder -= 1
					$InformationLable.text = String(informationSelectionOrder)
			# Update Self
			millitarySelectionOrder = null
			selected-=1
			$MillitaryLable.text = ""


func _on_DiplomaticArea_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
		if $Diplomatic.visible:
			if diplomaticSelectionOrder == null:
				diplomaticSelectionOrder = selected+1
				selected+=1
				$DiplomaticLable.text = String(diplomaticSelectionOrder)
				if selected == 3:
					createSelection()
			else:
				global_vars.turnOrder = null
				#Update others
				if millitarySelectionOrder != null:
					if millitarySelectionOrder > diplomaticSelectionOrder:
						millitarySelectionOrder -= 1
						$MillitaryLable.text = String(millitarySelectionOrder)
				if informationSelectionOrder != null:
					if informationSelectionOrder > diplomaticSelectionOrder:
						informationSelectionOrder -= 1
						$InformationLable.text = String(informationSelectionOrder)
				
				# Update Self
				diplomaticSelectionOrder = null
				selected-=1
				$DiplomaticLable.text = ""


func _on_InformationArea_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
		if informationSelectionOrder == null:
			informationSelectionOrder = selected+1
			selected+=1
			$InformationLable.text = String(informationSelectionOrder)
			if selected == 3 or (selected == 2 and global_vars.millitaryTurn):
				createSelection()
		else:
			global_vars.turnOrder = null
			#Update Others
			if diplomaticSelectionOrder != null:
				if diplomaticSelectionOrder > informationSelectionOrder:
					diplomaticSelectionOrder -= 1
					$DiplomaticLable.text = String(diplomaticSelectionOrder)
					
			if millitarySelectionOrder != null:
				if millitarySelectionOrder > informationSelectionOrder:
					millitarySelectionOrder -= 1
					$MillitaryLable.text = String(millitarySelectionOrder)
			# Update Self
			informationSelectionOrder = null
			selected-=1
			$InformationLable.text = ""

func createSelection():
	selection = []
	
	if global_vars.millitaryTurn:
		selection.append (2)
	
	if millitarySelectionOrder == 1:
		selection.append (3)
	if diplomaticSelectionOrder == 1:
		selection.append (2)
	if informationSelectionOrder == 1:
		selection.append (4)
	
	if millitarySelectionOrder == 2:
		selection.append (3)
	if diplomaticSelectionOrder == 2:
		selection.append (2)
	if informationSelectionOrder == 2:
		selection.append (4)
	
	if millitarySelectionOrder == 3:
		selection.append (3)
	if diplomaticSelectionOrder == 3:
		selection.append (2)
	if informationSelectionOrder == 3:
		selection.append (4)

	global_vars.turnOrder = selection
