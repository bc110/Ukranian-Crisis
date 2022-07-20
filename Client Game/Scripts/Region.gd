extends Area2D

onready var global_vars = get_node("/root/Global")

export var territoryName := "temp"
export var ajacentTerritories := ["",""]
export var value := 0
export var type := "Ethnic"
export var debug := false
#var BOARD_DIMENTIONS = Vector2(xDIM,yDIM)

var battle = true

var irrUA = 0
var irrUANu = 0
var reUA = 0
var reUANu = 0

var irrRU = 0
var irrRUNu = 0
var reRU = 0
var reRUNu = 0

var special = 0

var controlledBy = null

func _ready():
	checkControl()

func checkControl():
	print("Check")
	if controlledBy == global_vars.playerNation:
		global_vars.playerTerritoryScore -= value
	elif controlledBy != null:
		global_vars.enemyTerritoryScore -= value
		
	if (irrUA+reUA == 0) and (irrRU+reRU == 0):
		controlledBy = null
	elif (irrUA+reUA > 0) and (irrRU+reRU > 0):
		controlledBy = null
	elif (irrUA+reUA > 0) and (irrRU+reRU == 0):
		controlledBy = "UA"
	elif (irrUA+reUA == 0) and (irrRU+reRU > 0):
		controlledBy = "RU"	
		
	print(controlledBy)
		
	if controlledBy == global_vars.playerNation:
		global_vars.playerTerritoryScore += value
	elif controlledBy != null:
		global_vars.enemyTerritoryScore += value
		
func updateText():
	if debug:
		$Control.get_child(0).text = territoryName
		if type == "Ethnic": $Control.get_child(0).text = territoryName + "["+str(value)+"]"
		
		$Control.get_child(0).add_color_override("font_color", Color(0,0,0))
		if global_vars.moveLocations.has(territoryName):
			$Control.get_child(0).add_color_override("font_color", Color(0,0.5,0))
			
		if global_vars.battle:
			if battle:
				if (irrUA+reUA > 0) and (irrRU+reRU > 0):
					$Control.get_child(0).add_color_override("font_color", Color(0.9,0,0))
		
		if type == "Ethnic":
			if controlledBy == "RU":
				$Control.get_child(1).text = "Russian Controlled"
				$Control.get_child(1).visible = true
			elif controlledBy == "UA":
				$Control.get_child(1).text = "Ukranian Controlled"
				$Control.get_child(1).visible = true
			else:
				$Control.get_child(1).visible = false
		else:
			$Control.get_child(1).visible = false
		
		var specialForces = ""
		if special > 0:
			specialForces = "+"+str(special)+" SF"
		$Control.get_child(2).text = "RU : "+str(irrRU+reRU*4)+"("+str(irrRUNu+reRUNu*4)+")"+specialForces
		$Control.get_child(3).text = "UA : "+str(irrUA+reUA*2)+"("+str(irrUANu+reUANu*2)+")"
		$Control.get_child(3).visible = (type != "Russia")

func updateTerritory():
	if territoryName == global_vars.territoryName:
		# Ukraine
		global_vars.irregularUAToShow = irrUA
		global_vars.irregularUANuToShow = irrUANu
		global_vars.regularUAToShow = reUA
		global_vars.regularUANuToShow = reUANu
		
		# Russia
		global_vars.irregularRUToShow = irrRU
		global_vars.irregularRUNuToShow = irrRUNu
		global_vars.regularRUToShow = reRU
		global_vars.regularRUNuToShow = reRUNu
		global_vars.specialToShow = special
		global_vars.updateTerritory = true

func _process(_delta):
	updateText()
	if global_vars.territoryAction["TerritoryName"] == territoryName:
		print("Move1")
		# -- Neutrilising --
		if global_vars.territoryAction["Action"] == "neutrilize":
			if global_vars.territoryAction["UnitEffected"] == "UaIr":
				irrUA -= 1
				irrUANu +=1
			elif global_vars.territoryAction["UnitEffected"] == "RuIr":
				irrRU -= 1
				irrRUNu +=1
			elif global_vars.territoryAction["UnitEffected"] == "UaRe":
				reUA -= 1
				reUANu +=1
			elif global_vars.territoryAction["UnitEffected"] == "RuRe":
				reRU -= 1
				reRUNu +=1
		
		# -- Deploying --
		elif global_vars.territoryAction["Action"] == "deployed":
			if global_vars.territoryAction["UnitEffected"] == "UaIr":
				irrUA += 1
			elif global_vars.territoryAction["UnitEffected"] == "RuIr":
				irrRU += 1
			elif global_vars.territoryAction["UnitEffected"] == "UaRe":
				reUA += 1
			elif global_vars.territoryAction["UnitEffected"] == "RuRe":
				reRU += 1
			if global_vars.territoryAction["UnitEffected"] == "Special":
				special += 1
		
		# -- Removing --
		elif global_vars.territoryAction["Action"] == "removed":
			print("Move1")
			if global_vars.territoryAction["UnitEffected"] == "UaIr":
				irrUA -= 1
			elif global_vars.territoryAction["UnitEffected"] == "RuIr":
				irrRU -= 1
			elif global_vars.territoryAction["UnitEffected"] == "UaNuIr":
				irrUANu -= 1
			elif global_vars.territoryAction["UnitEffected"] == "RuNuIr":
				irrRUNu -= 1
				
			elif global_vars.territoryAction["UnitEffected"] == "UaRe":
				reUA -= 1
			elif global_vars.territoryAction["UnitEffected"] == "RuRe":
				reRU -= 1
			elif global_vars.territoryAction["UnitEffected"] == "UaNuRe":
				reUANu -= 1
			elif global_vars.territoryAction["UnitEffected"] == "RuNuRe":
				reRUNu -= 1
			elif global_vars.territoryAction["UnitEffected"] == "Special":
				special -= 1
			if global_vars.movingUnit != null:
				global_vars.moveLocations = ajacentTerritories.duplicate(true)
				print(global_vars.moveLocations)
				
		global_vars.territoryAction = {"TerritoryName":null,"UnitEffected":null,"Action":null}
		updateTerritory()
		checkControl()
		
	if global_vars.removeUnit != null:
		if territoryName == global_vars.territoryName:
			if global_vars.removeUnit == "UaIr":
				irrUA -= 1
			if global_vars.removeUnit == "RuIr":
				irrRU -= 1
			global_vars.moveLocations = ajacentTerritories.duplicate(true)
			global_vars.removeUnit = null		
			checkControl()
			
	if global_vars.killUnit:
		if territoryName == global_vars.territoryName:
			if global_vars.neutriliseUnitName == "RuNuIr":
				irrRUNu -=1
			elif global_vars.neutriliseUnitName == "UaNuIr":
				irrUANu -=1
				
			# Ukraine
			global_vars.irregularUAToShow = irrUA
			global_vars.irregularUANuToShow = irrUANu
			global_vars.regularUAToShow = reUA
			global_vars.regularUANuToShow = reUANu
			
			# Russia
			global_vars.irregularRUToShow = irrRU
			global_vars.irregularRUNuToShow = irrRUNu
			global_vars.regularRUToShow = reRU
			global_vars.regularRUNuToShow = reRUNu
			global_vars.specialToShow = special
			
			global_vars.killUnit = false
			global_vars.updateTerritory = true
			checkControl()
			
			
	if global_vars.removeBattle:
		if territoryName == global_vars.territoryName:
			battle = false
			global_vars.removeBattle = false
			global_vars.terrioryBattle = false
	if global_vars.resetBattle:
		if !battle:
			battle = true
			

func _on_Area2D_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
		global_vars.terrioryBattle = battle
		if global_vars.movingUnit !=null:
			print(global_vars.moveLocations)
			if global_vars.moveLocations.has(territoryName):
				global_vars.moveLocations = []
				var territoryAction = {"TerritoryName":territoryName,"UnitEffected":global_vars.movingUnit,"Action":"deployed"}
				if global_vars.movingUnit == "UaIr":
					irrUA += 1
					global_vars.movingUnit = null
					global_vars.message("Deployed Irregular to "+territoryName,"Action")
				if global_vars.movingUnit == "RuIr":
					irrRU += 1
					global_vars.movingUnit = null
					global_vars.message("Deployed Irregular to "+territoryName,"Action")
				if global_vars.movingUnit == "UaRe":
					reUA += 1
					global_vars.movingUnit = null
					global_vars.message("Deployed Regular to "+territoryName,"Action")
				if global_vars.movingUnit == "RuRe":
					reRU += 1
					global_vars.movingUnit = null
					global_vars.message("Deployed Regular to "+territoryName,"Action")
				var moveData = {"MoveType":"TerritoryAction","Action":territoryAction}
				Server.SendMove(moveData,get_instance_id())
				checkControl()
		elif global_vars.showingMap:
				global_vars.showingTerritory = true
				global_vars.showingMap = false
				
				global_vars.territoryName = territoryName
				# Ukraine
				global_vars.irregularUAToShow = irrUA
				global_vars.irregularUANuToShow = irrUANu
				global_vars.regularUAToShow = reUA
				global_vars.regularUANuToShow = reUANu
				
				# Russia
				global_vars.irregularRUToShow = irrRU
				global_vars.irregularRUNuToShow = irrRUNu
				global_vars.regularRUToShow = reRU
				global_vars.regularRUNuToShow = reRUNu
				global_vars.specialToShow = special
		else:
			if global_vars.phase == 3:
				if !global_vars.showMillitary:
					# Ukraine Placing
					if global_vars.playerNation == "UA":
						if type != "Russia":
							# Irregular
							if global_vars.unitSelected == "irrgular":
								irrUA += 1
								global_vars.placeUnit("Here")
								var territoryAction = {"TerritoryName":territoryName,"UnitEffected":"UaIr","Action":"deployed"}
								var moveData = {"MoveType":"TerritoryAction","Action":territoryAction}
								Server.SendMove(moveData,get_instance_id())
								global_vars.message("Deployed Irregular to "+territoryName,"Action")
							if((irrRU+irrRUNu) == 0):
								# Regular
								if global_vars.unitSelected == "regular":
									reUA += 1
									global_vars.placeUnit("Here")
									var territoryAction = {"TerritoryName":territoryName,"UnitEffected":"UaRe","Action":"deployed"}
									var moveData = {"MoveType":"TerritoryAction","Action":territoryAction}
									Server.SendMove(moveData,get_instance_id())
									global_vars.message("Deployed Regular to "+territoryName,"Action")
					# Russia Placing
					else:
						#special
						if global_vars.unitSelected == "special":
									special += 1
									global_vars.placeUnit("Here")
									var territoryAction = {"TerritoryName":territoryName,"UnitEffected":"Special","Action":"deployed"}
									var moveData = {"MoveType":"TerritoryAction","Action":territoryAction}
									Server.SendMove(moveData,get_instance_id())
									global_vars.message("Deployed Special Forces to "+territoryName,"Action")
						if global_vars.unitSelected == "irrgular":
							if(special > 0):
								if (type == "Ethnic" and (value > 0)):
									# Irregular
									irrRU += 1
									global_vars.placeUnit("Here")
									var territoryAction = {"TerritoryName":territoryName,"UnitEffected":"RuIr","Action":"deployed"}
									var moveData = {"MoveType":"TerritoryAction","Action":territoryAction}
									Server.SendMove(moveData,get_instance_id())
									global_vars.message("Deployed Irregular to "+territoryName,"Action")
						# Regular
						if((irrUA+irrUANu) == 0):
							if global_vars.unitSelected == "regular":
								if type == "Russia":
									reRU += 1
									global_vars.placeUnit("Here")
									var territoryAction = {"TerritoryName":territoryName,"UnitEffected":"RuRe","Action":"deployed"}
									var moveData = {"MoveType":"TerritoryAction","Action":territoryAction}
									Server.SendMove(moveData,get_instance_id())
									global_vars.message("Deployed Regular to "+territoryName,"Action")
					checkControl()
