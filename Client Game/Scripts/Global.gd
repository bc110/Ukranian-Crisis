extends Node

# -- game state --
var phase = 1
var turn = 1
var holder = false
var messages = []

var pickingCards = false
var pickingType = null
var t = Timer.new()

var showScores = false

var waitingOnData = false
var showWaiting = false

var rolling = false
var rolled = false

var useTerritoryScores = false
var playerTerritoryScore = 0
var enemyTerritoryScore = 0

var showEndCard = false
var showCeasefire = false

var enemyCeasefireValue = 0
var gameOver = false
# -- Turn picker --
var pickingOrder = false
var turnOrder = null
var turnIndex = 0
var ceaseCount = 0

var pickingTurnType = false

var millitaryTurn = null
var enemySelectedTurn = null
var turnPlayer = true

# -- Territory Map Screen --
var showingMap = false
var showingTerritory = false
var updateTerritory = false
var territoryName = "No Name Found"

var irregularUAToShow = 0
var irregularUANuToShow = 0
var regularUAToShow = 0
var regularUANuToShow = 0

var irregularRUToShow = 0
var irregularRUNuToShow = 0
var regularRUToShow = 0
var regularRUNuToShow = 0

var specialToShow = 0

# -- Diplomatic Screen --
var showDiplomatic = false

var showPointSelector = false

var PPToUse = 0
var RPToUse = 0

var MinRP = 0
var MinTotalPoints = 0
var selectedTokenRank = 3

var selectedToken = null

# Diplomatic Values
var USPos = 2
var USValue = 3

var DEPos = 1
var DEValue = 3

var GBPos = 1
var GBValue = 2

var FRPos = 1
var FRValue = 2

var ROPos = 1
var ROValue = 1

var BYPos = 1
var BYValue = 1

var PLPos = 2
var PLValue = 1

var extraRP = 0

# -- Millitary Pieces Screen --
var showMillitary = false
var reloadPieces = false

var unitSelected

var irResUA = 14
var irMobUA = 0

var irResRU = 10
var irMobRU = 0

var reResUA = 13
var reMobUA = 0

var reResRU = 14
var reMobRU = 0

var specialRes = 3
var specialMob = 0

var showInformation = false

# -- Neutrilize Unit --
var territoryAction = {"TerritoryName":null,"UnitEffected":null,"Action":null}

var neutriliseUnit = false
var neutriliseUnitName = null
var neutrilized = false
var neutriliseUnitLeft = 0

# -- Combat Phase --
var symbolic = false
var symbolicDamage = 0

var CombatPhase = false
var CombatStartScreen = false
var OperationalSegments = 0
var CombatPoints = 0

var resetBattle = false
var terrioryBattle = false
var removeBattle = false

var movingUnit = null
var removeUnit = null
var hideTerritory = false
var moveLocations = []

var killUnit = false
var killUnitName = null

var battleDataRecived = false
var showBattle = false
var battle = false
var hits = 0

var IrUaBattle = 0
var IrUaNuBattle = 0
var ReUaBattle = 0
var ReUaNuBattle = 0

var IrRuBattle = 0
var IrRuNuBattle = 0
var ReRuBattle = 0
var ReRuNuBattle = 0

# -- Varibles about effort cards --
var minorArray = [1,2,2,3,3,4]
var moderateArray = [2,3,3,4,4,5]

# -- Player varibles --
var playerPrestege = 45
var playerNation = "RU"

var playerMilCard = "null"
var playerDipCard = "null"
var playerInfCard = "null"

var playerMilScore = "null"
var playerDipScore = "null"
var playerInfScore = "null"

# -- Enemy Varibles --
var enemyPrestege = 10

var enemyMilScore = null
var enemyDipScore = null
var enemyInfScore = null

var enemyMilCard = "null"
var enemyDipCard = "null"
var enemyInfCard = "null"

# Called when the node enters the scene tree for the first time.
func _ready():
	startState()
	randomize()
	
func startState():
	#Sets things to show players
	showingMap = true
	phase = 1
	waitingOnData = true
	
	#Reset Varibles for new turn
	playerMilCard = null
	playerDipCard = null
	playerInfCard = null

	playerMilScore = null
	playerDipScore = null
	playerInfScore = null
	
	enemyMilCard = null
	enemyDipCard = null
	enemyInfCard = null
	
	message("Please select effort cards to use this turn","Error")
	
func setPhase(phaseID):
	phase = phaseID
	
func showHolder():
	holder = true
	showingMap = false

func nowPickingCards(type): 
	pickingType = type
	pickingCards = true
	
func minorSelected(type):
	if holder:
		pickingCards = false
		holder = false
		var value = 0
		if type == "Minor":
			value = 0
		elif type == "Moderate":
			value = 0
		
		if pickingType == "Millitary":
			playerMilCard = type
			playerMilScore = value
		elif pickingType == "Diplomacy":
			playerDipCard = type
			playerDipScore = value
		elif pickingType == "Information":
			playerInfCard = type
			playerInfScore = value
			
		print(type+" Selected, you got a:",value)
		t.set_wait_time(0.01)
		t.set_one_shot(true)
		yield(t, "timeout")
		showingMap = true
		
func findNextPhase():
	print("Finding Next Phase")
	if phase == 1:
		phase = 0
		pickingTurnType = true
		waitingOnData = true
	elif turnIndex < 3:
		phase = turnOrder[turnIndex]
		turnIndex += 1
		print(phase)
		
		# -- Diplomatic phase --
		if phase == 2:
			message("Diplomatic Phase","Error")
			waitingOnData = true
			if playerPrestege > enemyPrestege:
				turnPlayer = true
				message("You are turn player","Error")
			elif playerPrestege ==enemyPrestege:
				if playerNation == "RU":
					turnPlayer = true
					message("You are turn player","Error")
				else:
					turnPlayer = false
			else:
				turnPlayer = false
			showDiplomatic = true
		
		# -- Millitary phase --
		if phase ==3:
			message("Millitary Phase","Error")	
			rolled = false
			if millitaryTurn:
				useTerritoryScores = true
				waitingOnData = true
				if playerPrestege > enemyPrestege:
					turnPlayer = true
					message("You are turn player","Error")
				elif playerPrestege ==enemyPrestege:
					if playerNation == "RU":
						turnPlayer = true
						message("You are turn player","Error")
					else:
						turnPlayer = false
				else:
					turnPlayer = false
				showingMap = true
				CombatPhase = true
				OperationalSegments = 5
				
				if enemyMilCard == "Minor": OperationalSegments = 1
				if playerMilCard == "Minor": OperationalSegments = 1
				
				if enemyMilCard == "Moderate": OperationalSegments = 2
				if playerMilCard == "Moderate": OperationalSegments = 2
				
				if enemyMilCard == "Major": OperationalSegments = 3
				if playerMilCard == "Major": OperationalSegments = 3
				
				CombatPoints = minorArray[randi() % minorArray.size()]
				phase = 5
				neutriliseUnit = false
				CombatStartScreen = true
				neutriliseUnitLeft = 0
				
				resetBattle = true
			else:					
				waitingOnData = true
				if playerPrestege > enemyPrestege:
					turnPlayer = true
					message("You are turn player","Error")
				elif playerPrestege ==enemyPrestege:
					if playerNation == "RU":
						turnPlayer = true
						message("You are turn player","Error")
					else:
						turnPlayer = false
				else:
					turnPlayer = false
				showMillitary = true
		
		# -- Information Phase --
		if phase == 4:
			message("Information Phase","Error")	
			showInformation = true
			waitingOnData = true
			if playerPrestege > enemyPrestege:
				turnPlayer = true
				message("You are turn player","Error")
			elif playerPrestege ==enemyPrestege:
				if playerNation == "RU":
					turnPlayer = true
					message("You are turn player","Error")
				else:
					turnPlayer = false
			else:
				turnPlayer = false
	else:
		message("Turn Over","Error")
		showEndCard = true
		if turn == 8:
			gameOver = true
		turnIndex = 0
		startState()
		
func nextPhase():
	if phase == 0:
		if pickingTurnType:
			if millitaryTurn != null:
				
				if millitaryTurn:message("Wants a combat turn","Action")	
				else:message("Wants a strategic turn","Action")				
				var moveData = {"MoveType":"SelectTurnType","millitaryTurn":millitaryTurn}
				Server.SendMove(moveData,get_instance_id())
				
				showInformation = false
				pickingTurnType = false
				
				if waitingOnData:
					showWaiting = true
				else:
					if (millitaryTurn == enemySelectedTurn):
						millitaryTurn = millitaryTurn and enemySelectedTurn
						
						if millitaryTurn: useTerritoryScores = true
						print("picking")
						pickingOrder = true
					else:
						print(millitaryTurn)
						showCeasefire = true
		elif turnOrder != null:
			if pickingOrder:
				pickingOrder = false
				turnIndex = 0
				
				if millitaryTurn: turnIndex = 1
				message("Picked the turn order : "+phaseName(turnOrder[0])+", "+phaseName(turnOrder[1])+", "+phaseName(turnOrder[2]),"Action")
				var moveData = {"MoveType":"SelectOrder","Order":turnOrder}
				Server.SendMove(moveData,get_instance_id())
				findNextPhase()
				waitingOnData = true
	elif phase == 1:
		if (playerMilScore != null) and (playerDipScore != null) and (playerInfScore != null):
			print("Next Phase Called for")
			showingMap = false
			showScores = true
			
			message("Selected Effort Cards","Action")	
			
			var moveData = {"MoveType":"SelectEffortCart","MillitaryCard":playerMilCard,"DiplomaticCard":playerDipCard,"InformationCard":playerInfCard}
			Server.SendMove(moveData,get_instance_id())
			
			if waitingOnData:
				showWaiting = true
			else:
				findNextPhase()
				waitingOnData = true
			
	elif phase == 2:
		if turnPlayer:
			print("Next Phase Called for")
			turnPlayer = false
			var moveData = {"MoveType":"EndDiplomacy"}
			Server.SendMove(moveData,get_instance_id())
			if !waitingOnData:
				showingMap = false
				showDiplomatic = false
				findNextPhase()
			else:
				waitingOnData = false
			
	elif phase == 3:
		if turnPlayer:
			print("Next Phase Called for")
			turnPlayer = false
			
			var moveData = {"MoveType":"EndMillitary"}
			Server.SendMove(moveData,get_instance_id())
			
			if !waitingOnData:
				showingMap = false
				showMillitary = false
				findNextPhase()
			else:
				waitingOnData = false
	
	elif phase == 4:
		print("EndInfo")
		showInformation = false
		showingMap = false
		waitingOnData = true
		findNextPhase()
		
	elif phase == 5:
		if turnPlayer:
			resetBattle = false
			CombatPoints = 0
			OperationalSegments -= 1
			battle = true
			phase = 6
		
	elif phase == 6:
		if turnPlayer:
			var moveData = {"MoveType":"EndBattle"}
			Server.SendMove(moveData,get_instance_id())
			turnPlayer = false
			
			if !waitingOnData:
				if OperationalSegments > 0:
					battle = true
					CombatPoints = minorArray[randi() % minorArray.size()]
					resetBattle = true
					phase = 5
					waitingOnData = true
					CombatStartScreen = true
				else:
					CombatPhase = false
					findNextPhase()
			else:
				waitingOnData = false
			
func tokenSelected(name):
	if selectedToken == name:
		tokenUnselected()
	else:
		selectedToken = name
		
		if name == "US":
			MinRP = USPos
			MinTotalPoints = USPos+USValue
			selectedTokenRank = USValue
		if name == "DE":
			MinRP = DEPos
			MinTotalPoints = DEPos+DEValue
			selectedTokenRank = DEValue
			
			
		if name == "GB":
			MinRP = GBPos
			MinTotalPoints = GBPos+GBValue
			selectedTokenRank = GBValue
		if name == "FR":
			MinRP = FRPos
			MinTotalPoints = FRPos+FRValue
			selectedTokenRank = FRValue
		
		if name == "RO":
			MinRP = ROPos
			MinTotalPoints = ROPos+ROValue
			selectedTokenRank = ROValue
		if name == "BY":
			MinRP = BYPos
			MinTotalPoints = BYPos+BYValue
			selectedTokenRank = BYValue
		if name == "PL":
			MinRP = PLPos
			MinTotalPoints = PLPos+PLValue
			selectedTokenRank = PLValue
		
		if playerNation == "UA": MinRP += 1
		if playerNation == "RU": MinRP -= 1
		
		if !turnPlayer:
			tokenUnselected()
			print("Cannot select as you are not turn player")
		elif MinRP == 4:
			tokenUnselected()
			print("Cannot move "+name+" more")
		elif MinRP == 0:
			tokenUnselected()
			print("Cannot move "+name+" more")
		elif MinRP <= playerDipScore:
			print(name+" Selected!")
			showPointSelector = true
			RPToUse = MinRP
		else:
			tokenUnselected()
			print("Not enough RP to select "+name)

func tokenUnselected():
	selectedToken = null
	showPointSelector = false
	PPToUse = 0
	RPToUse = 0

func attemptMove(moveArray):
	var pointsUsed = RPToUse + PPToUse
	
	var text = "Rolled :"
	var rolledTotal = 0
	
	if pointsUsed >= MinTotalPoints:
		for x in range(0,selectedTokenRank):
			var rolled = moveArray[x]
			rolledTotal += rolled
			text += (" " +String(rolled))
		print(text)
		var moveDataReduce = {"MoveType":"IncreasePrestege","value":-PPToUse}
		Server.SendMove(moveDataReduce,get_instance_id())
		if rolledTotal <= pointsUsed:
			print("Success Moved "+selectedToken)
			message("Successfully Moved "+selectedToken,"Action")
			
			var positionChange = 0
			if playerNation == "UA": positionChange = 1
			else:positionChange = -1
			
			if selectedToken == "US": USPos += positionChange
			if selectedToken == "DE": DEPos += positionChange
			
			if selectedToken == "GB": GBPos += positionChange
			if selectedToken == "FR": FRPos += positionChange
			
			if selectedToken == "RO": ROPos += positionChange
			if selectedToken == "BY": BYPos += positionChange
			if selectedToken == "PL": PLPos += positionChange
			
			var moveData = {"MoveType":"MoveCountry","CountryName":selectedToken,"PositionChange":positionChange}			
			Server.SendMove(moveData,get_instance_id())

		else:
			message("Failed to Move "+selectedToken,"Action")
			var moveData = {"MoveType":"MoveCountry","CountryName":selectedToken,"PositionChange":0}			
			Server.SendMove(moveData,get_instance_id())
			print("Falied To Move "+selectedToken)
		playerDipScore -= RPToUse
		playerPrestege -= PPToUse
		tokenUnselected()

func moblizeUnit(type,nation):
	var costMultiplier = 1
	if nation != playerNation:
		costMultiplier = 0
		
	if nation == "UA":
		if (playerMilScore > 0) or (nation != playerNation):
			if type == "irrgular":
				irResUA -= 1
				irMobUA += 1
			elif type  == "regular":
				reResUA -= 1
				reMobUA += 1
			playerMilScore -= 1*costMultiplier
			reloadPieces = true
	else:
		if (playerMilScore > 0) or (nation != playerNation):
			if type == "irrgular":
				irResRU -= 1
				irMobRU += 1
			elif type  == "regular":
				reResRU -= 1
				reMobRU += 1
			elif type == "special":
				specialRes -= 1
				specialMob += 1
			playerMilScore -= 1*costMultiplier
			reloadPieces = true

func selectUnit(type):
	if playerMilScore > 0:
		yield(get_tree().create_timer(0.5), "timeout")
		unitSelected = type
		playerMilScore -= 1
		playerPrestege -= 1
		if type == "irrgular":
			playerPrestege += 1
			if playerNation == "UA": irMobUA -= 1
			else: irMobRU -= 1
		elif type == "special":
			playerPrestege += 1
			specialMob -= 1
		else:
			if playerNation == "UA": reMobUA -= 1
			else: reMobRU -= 1
		showMillitary = false
			
func placeUnit(_place):
	#if place.valid == true:
	showMillitary = true
	unitSelected = null
			
func message(message,type):
	if type == "Error":
		messages.append({"Message":(message),"Color":"yellow"})
	if type == "Action":
		# Get player name
		var meassageName = ""
		var meassageEnemy = ""
		if playerNation == "UA":
			meassageName = "Ukraine(you) : "
			meassageEnemy = "Ukraine(enemy) : "
		else:
			meassageName = "Russia(you) : "
			meassageEnemy = "Russia(enemy) : "
		
		# Set own message
		messages.append({"Message":(meassageName+message),"Color":"#3dd33c"})
		
		#SendMessage
		var enemyMessage = {"Message":(meassageEnemy+message),"Color":"#ff5d5d"}
		
		var moveData = {"MoveType":"Message","Message":enemyMessage}
		Server.SendMove(moveData,get_instance_id())
func phaseName(index):
	if index == 2:
		return "Diplomatic"
	if index == 3:
		return "Millitary"
	if index == 4:
		return "Information"
# -- Return Functions --
func getHolder(): return holder
func getPhase(): return phase
func pickCards(): return pickingCards
