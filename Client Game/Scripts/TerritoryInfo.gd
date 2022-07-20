extends Sprite


onready var global_vars = get_node("/root/Global")

const BOARD_DIMENTIONS = Vector2(9,8)
var irrigular = 1
var irrigularNu = 0
var regular = 1
var regularNu = 0

var irrigularRU = 1
var irrigularRUNu = 0
var regularRU = 1
var regularRUNu = 0
var special = 0

var unitSelected = null

var territoryName = "Error Name Not Found"

func _ready():
	pass # Replace with function body.


func _process(_delta):
	if global_vars.showingTerritory and (visible == false):
		$Label.text = global_vars.territoryName
		irrigular = global_vars.irregularUAToShow
		irrigularNu = global_vars.irregularUANuToShow
		regular = global_vars.regularUAToShow
		regularNu = global_vars.regularUANuToShow
		
		irrigularRU = global_vars.irregularRUToShow
		irrigularRUNu = global_vars.irregularRUNuToShow
		regularRU = global_vars.regularRUToShow
		regularRUNu = global_vars.regularRUNuToShow
		special = global_vars.specialToShow
		loadTerritory()
		visible = true
		
	if global_vars.updateTerritory:
		global_vars.updateTerritory = false
		for n in self.get_children():
			if !((n is Label) or (n is Button) or (n == $Die)):
				self.remove_child(n)
				n.queue_free()
		irrigular = global_vars.irregularUAToShow
		irrigularNu = global_vars.irregularUANuToShow
		regular = global_vars.regularUAToShow
		regularNu = global_vars.regularUANuToShow
		
		irrigularRU = global_vars.irregularRUToShow
		irrigularRUNu = global_vars.irregularRUNuToShow
		regularRU = global_vars.regularRUToShow
		regularRUNu = global_vars.regularRUNuToShow
		special = global_vars.specialToShow
		loadTerritory()
		
	if global_vars.hideTerritory:
		global_vars.hideTerritory = false
		global_vars.showingTerritory = false
		global_vars.showingMap = true
		visible = false
		for n in self.get_children():
			if !((n is Label) or (n is Button) or (n == $Die)):
				self.remove_child(n)
				n.queue_free()

func loadTerritory():
	var irrigularToSummon = irrigular
	var irrigularNuToSummon = irrigularNu
	var regularToSummon = regular
	var regularNuToSummon = regularNu
	
	var irrigularRUToSummon = irrigularRU
	var irrigularRUNuToSummon = irrigularRUNu
	var regularRUToSummon = regularRU
	var regularRUNuToSummon = regularRUNu
	var specialToSummon = special
	
	for y in range(BOARD_DIMENTIONS.y):
		for x in range(BOARD_DIMENTIONS.x):
			if irrigularToSummon > 0:
				addTile(Vector2((x-4.5)*60,(y-4)*60),"res://Prefabs/Millitary/Ukraine/IrrgularSmall.tscn",((-irrigular+global_vars.IrUaBattle)+irrigularToSummon)>0)	
				irrigularToSummon -= 1
			elif irrigularNuToSummon > 0:
				addTile(Vector2((x-4.5)*60,(y-4)*60),"res://Prefabs/Millitary/Ukraine/IrrgularNu.tscn",((-irrigularNu+global_vars.IrUaNuBattle)+irrigularNuToSummon)>0)
				irrigularNuToSummon -= 1
			elif regularToSummon > 0:
				addTile(Vector2((x-4.5)*60,(y-4)*60),"res://Prefabs/Millitary/Ukraine/RegularSmall.tscn",((-irrigular+global_vars.IrUaBattle)+irrigularToSummon)>0)	
				regularToSummon -= 1
			elif regularNuToSummon > 0:
				addTile(Vector2((x-4.5)*60,(y-4)*60),"res://Prefabs/Millitary/Ukraine/RegularNu.tscn",((-irrigularNu+global_vars.IrUaNuBattle)+irrigularNuToSummon)>0)
				regularNuToSummon -= 1
				
			elif irrigularRUToSummon > 0:
				addTile(Vector2((x-4.5)*60,(y-4)*60),"res://Prefabs/Millitary/Russia/IrrgularSmall.tscn",((-irrigularRU+global_vars.IrRuBattle)+irrigularRUToSummon)>0)
				irrigularRUToSummon -= 1
			elif irrigularRUNuToSummon > 0:
				addTile(Vector2((x-4.5)*60,(y-4)*60),"res://Prefabs/Millitary/Russia/IrrgularNu.tscn",((-irrigularRUNu+global_vars.IrRuNuBattle)+irrigularRUNuToSummon)>0)
				irrigularRUNuToSummon -= 1
			elif regularRUToSummon > 0:
				addTile(Vector2((x-4.5)*60,(y-4)*60),"res://Prefabs/Millitary/Russia/RegularSmall.tscn",((-irrigularRU+global_vars.IrRuBattle)+irrigularRUToSummon)>0)
				regularRUToSummon -= 1
			elif regularRUNuToSummon > 0:
				addTile(Vector2((x-4.5)*60,(y-4)*60),"res://Prefabs/Millitary/Russia/RegularNu.tscn",((-irrigularRUNu+global_vars.IrRuNuBattle)+irrigularRUNuToSummon)>0)
				regularRUNuToSummon -= 1
			elif specialToSummon > 0:
				addTile(Vector2((x-4.5)*60,(y-4)*60),"res://Prefabs/Millitary/Russia/SpecialSmall.tscn",false)
				specialToSummon -= 1
				
func addTile(pos,file,vis):
		var new_tile = load(file).instance()
		add_child(new_tile)
		new_tile.get_child(0).setVis(false)
		new_tile.position = (pos)

func _on_Button_button_down():
	global_vars.showingTerritory = false
	global_vars.showingMap = true
	
	global_vars.IrUaBattle = 0
	global_vars.IrUaNuBattle = 0
	global_vars.IrRuBattle = 0
	global_vars.IrRuNuBattle = 0
	
	visible = false
	for n in self.get_children():
		if !((n is Label) or (n is Button) or (n == $Die)):
			self.remove_child(n)
			n.queue_free()


func _on_KineticBattle_pressed():
	global_vars.showBattle = true
	global_vars.showingTerritory = false
	global_vars.removeBattle = true
	
	visible = false
	for n in self.get_children():
		if !((n is Label) or (n is Button) or (n == $Die)):
			self.remove_child(n)
			n.queue_free()
	


func _on_SymbolicBattle_pressed():
	global_vars.showBattle = true
	global_vars.showingTerritory = false
	global_vars.removeBattle = true
	global_vars.symbolic = true
	visible = false
	for n in self.get_children():
		if !((n is Label) or (n is Button) or (n == $Die)):
			self.remove_child(n)
			n.queue_free()
	
	"""
	var rolls = 0
	var hits = 0
	var enemyRolls = 0
	var enemyHits = 0
	global_vars.removeBattle = true
	if global_vars.playerNation == "UA":
		rolls += global_vars.IrUaBattle
		enemyRolls += global_vars.IrRuBattle
		enemyRolls += global_vars.IrRuNuBattle
		
	for x in range(0,rolls):
		if((randi() % 6) >= 0):
			print("Hit!")
			hits+=1
		else:
			print("Miss!")
	
	for x in range(0,enemyRolls):
		if((randi() % 6) >= 0):
			print("Enemy Hit!")
			enemyHits+=1
		else:
			print("Enemy Miss!")
			
	global_vars.enemyPrestege -= hits
	global_vars.playerPrestege -= enemyHits
	"""

func neutriliseUnit(unit):
	unitSelected = unit
	$Label2.visible = true
	var unitName = "unit"
	$Label2.text = "Roll "+str(global_vars.playerInfScore)+" or less to neutrilise "+unitName
	
	$Die.visible = true
	$Button3.visible = true
	$Cancel.visible = true
	
	$Button2.visible = false

func _on_Button3_pressed():
	$Button3.visible = false
	$Die.rollDie()
	global_vars.neutriliseUnitLeft -= 1
	
	# Wait for roll to be over
	var delay = ($Die.rolls+1)*$Die.delay+0.5	
	yield(get_tree().create_timer(delay), "timeout")
	
	if (global_vars.playerInfScore < $Die.value):
		$Label2.text = "You rolled "+str($Die.value)+" which is greater then \n "+str(global_vars.playerInfScore)+" so neutrilise failed"
		global_vars.message("Failied to netrilise unit in "+global_vars.territoryName,"Action")
	else:
		$Label2.text = "You rolled "+str($Die.value)+" which is less then \n or equal to "+str(global_vars.playerInfScore)+" so neutrilise successed"
		global_vars.territoryAction = {"TerritoryName":global_vars.territoryName,"UnitEffected":unitSelected,"Action":"neutrilize"}
		global_vars.message("Netrilise unit in "+global_vars.territoryName,"Action")
		var moveData = {"MoveType":"TerritoryAction","Action":global_vars.territoryAction}
		Server.SendMove(moveData,get_instance_id())
	global_vars.message("Has "+str(global_vars.neutriliseUnitLeft)+" attempts to neutrilise units remaining","Action")

func _on_Cancel_pressed():
	$Label2.visible = false
	$Die.visible = false
	$Button3.visible = false
	$Cancel.visible = false
	
	$Button2.visible = false
