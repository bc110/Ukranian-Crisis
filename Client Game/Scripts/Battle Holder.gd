extends Sprite

var irrigular = 0
var irrigularNu = 0
var regular = 0
var regularNu = 0

var irrigularRU = 0
var irrigularRUNu = 0
var regularRU = 0
var regularRUNu = 0

var ypush = 2.3
var xpush = 0.5

var ypushDie = 6.7
var xpushDie = 0.57

var hitsRemaining = 0
var dataSent = false

var dice = []
var units = []

var damage = 0

const BOARD_DIMENTIONS = Vector2(9,4)
const DICE_DIMENTIONS = Vector2(9,4)
onready var global_vars = get_node("/root/Global")

func _process(_delta):
	if global_vars.showBattle:
		if !visible:
			setup()
			global_vars.showingMap = false
		visible = true
	else:
		visible = false
		
	if global_vars.symbolic:
		$Title.text = "Symbolic Battle in \n"+global_vars.territoryName
	else:
		$Title.text = "Kinetic Battle in \n"+global_vars.territoryName
	if dataSent and global_vars.battleDataRecived:
		if !$Close.visible:
			getUnits()
			updateUnits()
			if global_vars.symbolic:
				global_vars.playerPrestege -= global_vars.symbolicDamage
				$SubTitle.text = "Enemy damages prestege by "+str(global_vars.symbolicDamage)
			else:
				$SubTitle.text = "Enemy Hits Recived\n battle over"
			$Waiting.visible = false
			$Close.visible = true
			
	#getEnemyUnits()
	if global_vars.hits > 0:
		var value = 0
		if global_vars.playerNation == "UA":value = calculateRussianValue()
		else:value = calculateUkraineValue()
		if value == 0:
			if global_vars.turnPlayer:
				$SubTitle.text = "As you are the attacker apply the rest of the hits as collateral\n Due to this you lose " + str(global_vars.hits) +" presteige"
				global_vars.playerPrestege -= global_vars.hits
				var moveData = {"MoveType":"IncreasePrestege","value":-global_vars.hits}
				Server.SendMove(moveData,get_instance_id())
			else:
				$SubTitle.text = "As you are the defender remaining hits do no addtional damage"
			global_vars.hits = 0
			updateButton()
			
func setup():
	getUnits()
	loadTerritory()
	print(global_vars.playerNation)
	if global_vars.playerNation == "UA":
		loadDice(calculateUkraineValue())
	else:
		loadDice(calculateRussianValue())
		
	dataSent = false
	global_vars.battleDataRecived = false
	
	$Button.visible = true
	$Continue.visible = false
	$Close.visible = false
	$Waiting.visible = false
	$SubTitle.text = "Please roll the dice"
	
	var unitList = [irrigular,irrigularNu,irrigularRU,irrigularRUNu,regular,regularNu,regularRU,regularRUNu]
	var moveData = {"MoveType":"StartBattle","Territory":global_vars.territoryName,"Units":unitList,"Symbolic":global_vars.symbolic}
	Server.SendMove(moveData,get_instance_id())

func loadTerritory():
	var irrigularToSummon = irrigular
	var irrigularNuToSummon = irrigularNu
	var regularToSummon = regular
	var regularNuToSummon = regularNu
	
	var irrigularRUToSummon = irrigularRU
	var irrigularRUNuToSummon = irrigularRUNu
	var regularRUToSummon = regularRU
	var regularRUNuToSummon = regularRUNu
	
	for y in range(BOARD_DIMENTIONS.y):
		for x in range(BOARD_DIMENTIONS.x):
			# -- Ukraine --
			# Irrgular
			if irrigularToSummon > 0:
				addTile(Vector2((x+xpush)*60,(y+ypush)*60),"res://Prefabs/Millitary/Ukraine/IrrgularSmall.tscn")	
				irrigularToSummon -= 1
			elif irrigularNuToSummon > 0:
				addTile(Vector2((x+xpush)*60,(y+ypush)*60),"res://Prefabs/Millitary/Ukraine/IrrgularNu.tscn")
				irrigularNuToSummon -= 1	
			# Regular
			elif regularToSummon > 0:
				addTile(Vector2((x+xpush)*60,(y+ypush)*60),"res://Prefabs/Millitary/Ukraine/RegularSmall.tscn")	
				regularToSummon -= 1
			elif regularNuToSummon > 0:
				addTile(Vector2((x+xpush)*60,(y+ypush)*60),"res://Prefabs/Millitary/Ukraine/RegularNu.tscn")
				regularNuToSummon -= 1
			
			
			# -- Russia --
			# Irregular
			elif irrigularRUToSummon > 0:
				addTile(Vector2((x+xpush)*60,(y+ypush)*60),"res://Prefabs/Millitary/Russia/IrrgularSmall.tscn")
				irrigularRUToSummon -= 1
			elif irrigularRUNuToSummon > 0:
				addTile(Vector2((x+xpush)*60,(y+ypush)*60),"res://Prefabs/Millitary/Russia/IrrgularNu.tscn")
				irrigularRUNuToSummon -= 1
			# Regular
			elif regularRUToSummon > 0:
				addTile(Vector2((x+xpush)*60,(y+ypush)*60),"res://Prefabs/Millitary/Russia/RegularSmall.tscn")
				regularRUToSummon -= 1
			elif regularRUNuToSummon > 0:
				addTile(Vector2((x+xpush)*60,(y+ypush)*60),"res://Prefabs/Millitary/Russia/RegularNu.tscn")
				regularRUNuToSummon -= 1

func calculateUkraineValue():
	var value = 0
	value += irrigular
	value += irrigularNu
	value += regular*2
	value += regularNu*2
	return value

func calculateRussianValue():
	var value = 0
	value += irrigularRU
	value += irrigularRUNu
	value += regularRU*4
	value += regularRUNu*4
	return value

func loadDice(amount):
	dice = []
	var diceToMake = amount
	
	for y in range(BOARD_DIMENTIONS.y):
		for x in range(BOARD_DIMENTIONS.x):
			if diceToMake > 0:
				diceToMake -= 1
				addDice(Vector2((x+xpushDie)*60,(y+ypushDie)*60))

func addDice(pos):
	var newDie = load("res://Prefabs/Die.tscn").instance()
	add_child(newDie)
	newDie.position = pos
	dice.append(newDie)

func addTile(pos,file):
	var new_tile = load(file).instance()
	add_child(new_tile)
	new_tile.position = (pos)
	units.append(new_tile)
		
func getUnits():
	#Ukraine
	irrigular = global_vars.IrUaBattle
	irrigularNu = global_vars.IrUaNuBattle
	regular = global_vars.ReUaBattle
	regularNu = global_vars.ReUaNuBattle
	
	# Russia
	irrigularRU = global_vars.IrRuBattle
	irrigularRUNu = global_vars.IrRuNuBattle
	regularRU = global_vars.ReRuBattle
	regularRUNu = global_vars.ReRuNuBattle
	
	
func getEnemyUnits():
	if global_vars.playerNation == "RU":
		#Ukraine
		irrigular = global_vars.IrUaBattle
		irrigularNu = global_vars.IrUaNuBattle
		regular = global_vars.ReUaBattle
		regularNu = global_vars.ReUaNuBattle
	else:
		#Russia
		irrigularRU = global_vars.IrRuBattle
		irrigularRUNu = global_vars.IrRuNuBattle
		regularRU = global_vars.ReRuBattle
		regularRUNu = global_vars.ReRuNuBattle
	
func updateUnits():
	for n in units:
		self.remove_child(n)
		n.queue_free()
	units = []
	getEnemyUnits()
	loadTerritory()
	$SubTitle.text = "Apply hits to the enemy units \nYou have "+str(global_vars.hits)+" hits remaining to apply"
	updateButton()
	
	
func unit_hit():
	print("huh")
	
func _on_unit_hit():
	print("huh2")

func _on_Button_pressed():
	$Button.visible = false
	for die in dice:
		die.rollDie()
	var delay = (dice[0].rolls+1)*dice[0].delay+0.5
	yield(get_tree().create_timer(delay), "timeout")
	global_vars.hits = 0
	for die in dice:
		if die.value>=4:
			global_vars.hits += 1
	print(global_vars.hits)
	$SubTitle.text = "Apply hits to the enemy units \nYou have "+str(global_vars.hits)+" hits remaining to apply"
	damage = 0
	if global_vars.symbolic:		
		if global_vars.playerNation == "RU":
			var value = 0
			value += irrigular
			value += irrigularNu
			value += regular
			value += regularNu
			#print("Ahh : "+str(value)+" : "+str(global_vars.hits))
			if value < global_vars.hits: damage = value
			else: damage = global_vars.hits
			
		if global_vars.playerNation == "UA":
			var value = 0
			value += irrigularRU
			value += irrigularRUNu
			value += regularRU
			value += regularRUNu
			if value < global_vars.hits: damage = value
			else: damage = global_vars.hits
		
		$SubTitle.text = "You symbolicly damage "+str(damage)+" units\n Reducing opponants presteige by "+str(damage)
		global_vars.enemyPrestege -= damage
		
		global_vars.hits = 0
	
	updateButton()
	
func updateButton():
	if global_vars.hits == 0:
		$Continue.visible = true

func _on_Close_pressed():
	global_vars.showBattle = false
	global_vars.showingTerritory = true
	global_vars.updateTerritory = true
	global_vars.showingMap = true
	
	global_vars.symbolic = false
	
	global_vars.IrUaBattle = 0
	global_vars.IrUaNuBattle = 0
	global_vars.IrRuBattle = 0
	global_vars.IrRuNuBattle = 0
	global_vars.ReUaBattle = 0
	global_vars.ReUaNuBattle = 0
	global_vars.ReRuBattle = 0
	global_vars.ReRuNuBattle = 0
	
	for n in units:
		self.remove_child(n)
		n.queue_free()
		
	for n in dice:
		self.remove_child(n)
		n.queue_free()
	dice = []
	units = []


func _on_Continue_pressed():
	$Continue.visible = false
	$Waiting.visible = true
	dataSent = true
	var moveData = {"MoveType":"BattleHits","Territory":global_vars.territoryName,"Units":[irrigular,irrigularNu,irrigularRU,irrigularRUNu,regular,regularNu,regularRU,regularRUNu],"Damage":damage}
	Server.SendMove(moveData,get_instance_id())
