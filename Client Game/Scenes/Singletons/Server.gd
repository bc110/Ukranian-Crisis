extends Node

var network = NetworkedMultiplayerENet.new()
#var ip = "78.144.127.26"
var ip = "127.0.0.1"
onready var global_vars = get_node("/root/Global")

var port = 1909

func _ready():
	ConnectToServer()

func ConnectToServer():
	network.create_client(ip,port)
	get_tree().set_network_peer(network)
	
	network.connect("connection_failed",self,"_OnConnectionFailed")
	network.connect("connection_succeeded",self,"_OnConnectionSucceeded")
	
func _OnConnectionFailed():
	print("Failed to connect")

func _OnConnectionSucceeded():
	print("Succesfully connected")
	
func SendMove(move_data,requester):
	rpc_id(1,"SendData",move_data,requester)

remote func ReturnData(move_data,requester):
	print("Data Sent")
	if(move_data["MoveType"]=="SelectOrder"):
		global_vars.turnOrder = move_data["Order"]
		global_vars.turnIndex = 0
		if global_vars.millitaryTurn: global_vars.turnIndex = 1
		global_vars.pickingOrder = false
		global_vars.findNextPhase()
		
		
	elif(move_data["MoveType"]=="SelectTurnType"):
		global_vars.waitingOnData = false
		global_vars.showWaiting = false
		
		global_vars.enemySelectedTurn = move_data["millitaryTurn"]
		
		if !global_vars.pickingTurnType:
			global_vars.waitingOnData = true
			
			if (global_vars.millitaryTurn == move_data["millitaryTurn"]):
				global_vars.millitaryTurn = global_vars.millitaryTurn and move_data["millitaryTurn"]
				print("Server Pcik")
				if global_vars.millitaryTurn: global_vars.useTerritoryScores = true
				
				global_vars.pickingOrder = true
			else:
				global_vars.showCeasefire = true
		
	elif(move_data["MoveType"]=="SelectEffortCart"):
		global_vars.enemyMilCard = move_data["MillitaryCard"]
		global_vars.enemyDipCard = move_data["DiplomaticCard"]
		global_vars.enemyInfCard = move_data["InformationCard"]
		global_vars.waitingOnData = false
		if global_vars.showWaiting:
			global_vars.showWaiting = false
			global_vars.findNextPhase()
			global_vars.waitingOnData = true
			
			
	elif(move_data["MoveType"]=="MoveCountry"):
		var selectedToken = move_data["CountryName"]
		var positionChange = move_data["PositionChange"]
		
		if selectedToken == "US": global_vars.USPos += positionChange
		if selectedToken == "DE": global_vars.DEPos += positionChange
		
		if selectedToken == "GB": global_vars.GBPos += positionChange
		if selectedToken == "FR": global_vars.FRPos += positionChange
		
		if selectedToken == "RO": global_vars.ROPos += positionChange
		if selectedToken == "BY": global_vars.BYPos += positionChange
		if selectedToken == "PL": global_vars.PLPos += positionChange
		
		
	elif(move_data["MoveType"]=="EndDiplomacy"):
		print("DipOver")
		if !global_vars.waitingOnData:
			global_vars.showingMap = false
			global_vars.showDiplomatic = false
			global_vars.findNextPhase()
		else:
			global_vars.waitingOnData = false		
			global_vars.turnPlayer = true
			global_vars.message("You are turn player","Error")
			
	elif(move_data["MoveType"]=="EndInformation"):
		print("End It!")
		print(global_vars.waitingOnData)
		if !global_vars.waitingOnData:
			global_vars.nextPhase()
		else:
			global_vars.waitingOnData = false		
			global_vars.turnPlayer = true
			global_vars.message("You are turn player","Error")
			
	elif(move_data["MoveType"]=="EndMillitary"):
		if !global_vars.waitingOnData:
			global_vars.showingMap = false
			global_vars.showMillitary = false
			global_vars.findNextPhase()
		else:
			global_vars.waitingOnData = false		
			global_vars.turnPlayer = true
			global_vars.message("You are turn player","Error")
			
	elif(move_data["MoveType"]=="EndBattle"):
		global_vars.turnPlayer = true
		global_vars.message("You are turn player","Error")
		
		if !global_vars.waitingOnData:
			if global_vars.OperationalSegments > 0:
				global_vars.battle = true
				global_vars.CombatPoints = global_vars.minorArray[randi() % global_vars.minorArray.size()]
				global_vars.resetBattle = true
				global_vars.phase = 5
				global_vars.CombatStartScreen = true
				global_vars.waitingOnData = true
			else:
				global_vars.CombatPhase = false
				global_vars.findNextPhase()
		else:
			global_vars.waitingOnData = false
	
	elif(move_data["MoveType"]=="IncreasePrestege"):
		global_vars.enemyPrestege += move_data["value"]
		if move_data["value"]>0:
			if !global_vars.waitingOnData:
				global_vars.nextPhase()
			else:
				global_vars.waitingOnData = false		
				global_vars.turnPlayer = true
				global_vars.message("You are turn player","Error")
	
	
	elif(move_data["MoveType"]=="ReducePrestege"):
		global_vars.enemyPrestege -= move_data["playerValue"]
		global_vars.playerPrestege -= move_data["enemyValue"]
		if !global_vars.waitingOnData:
			global_vars.nextPhase()
		else:
			global_vars.waitingOnData = false		
			global_vars.turnPlayer = true
			global_vars.message("You are turn player","Error")
	
	
	elif(move_data["MoveType"]=="Mobilize"):
		if global_vars.playerNation == "UA":
			global_vars.moblizeUnit(move_data["Unit"],"RU")
		else:
			global_vars.moblizeUnit(move_data["Unit"],"UA")
	
	elif(move_data["MoveType"]=="TerritoryAction"):
		global_vars.territoryAction = move_data["Action"]
		print(global_vars.territoryAction)
		
	elif(move_data["MoveType"]=="StartBattle"):
		global_vars.territoryName = move_data["Territory"]
		global_vars.showBattle = true
		global_vars.showingTerritory = false
		#"Symbolic":
		global_vars.symbolic = move_data["Symbolic"]
		
		print(move_data["Units"])
		
		#Ukraine
		global_vars.IrUaBattle = move_data["Units"][0]
		global_vars.IrUaNuBattle = move_data["Units"][1]

		#Russia
		global_vars.IrRuBattle = move_data["Units"][2]
		global_vars.IrRuNuBattle = move_data["Units"][3]
		
		#Ukraine
		global_vars.ReUaBattle = move_data["Units"][4]
		global_vars.ReUaNuBattle = move_data["Units"][5]

		#Russia
		global_vars.ReRuBattle = move_data["Units"][6]
		global_vars.ReRuNuBattle = move_data["Units"][7]
	
	elif(move_data["MoveType"]=="BattleHits"):
		global_vars.battleDataRecived = true
		global_vars.symbolicDamage = move_data["Damage"]
		if global_vars.playerNation == "UA":
			#Ukraine
			global_vars.IrUaBattle = move_data["Units"][0]
			global_vars.IrUaNuBattle = move_data["Units"][1]
			global_vars.ReUaBattle = move_data["Units"][4]
			global_vars.ReUaNuBattle = move_data["Units"][5]
		else:
			#Russia
			global_vars.IrRuBattle = move_data["Units"][2]
			global_vars.IrRuNuBattle = move_data["Units"][3]
			global_vars.ReRuBattle = move_data["Units"][6]
			global_vars.ReRuNuBattle = move_data["Units"][7]
	elif(move_data["MoveType"]=="Ceasefire"):
		global_vars.enemyCeasefireValue = move_data["value"]
	elif(move_data["MoveType"]=="CeaseClose"):
		global_vars.ceaseCount += 1
	elif(move_data["MoveType"]=="Message"):
		global_vars.messages.append(move_data["Message"])
	else:
		print("Unknown move type : "+move_data["MoveType"])
remote func SetStart(data):
	global_vars.playerNation = data["Nation"]
	global_vars.playerPrestege = data["PlayerPrestege"]
	global_vars.enemyPrestege = data["EnemyPrestege"]
