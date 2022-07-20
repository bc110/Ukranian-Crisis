extends Sprite

onready var global_vars = get_node("/root/Global")
const BOARD_DIMENTIONS = Vector2(9,3)

var currentlyVisable = false

var irrigular = 0
var irrigularToSummon
var regular = 0
var regularToSummon

var irrigularMob = 0
var irrigularMobToSummon
var regularMob = 0
var regularMobToSummon

var special = 0
var specialToSummon
var specialMob = 0
var specialMobToSummon

# Called when the node enters the scene tree for the first time.
func _ready():
	irrigular = global_vars.irResUA
	irrigularMob = global_vars.irMobUA
	pass # Replace with function body.
	
func _process(_delta):
	$ResourceTracker.text = "You have "+str(global_vars.playerMilScore)+" resource points to spend"
	if global_vars.showMillitary:
		if !currentlyVisable:
			currentlyVisable = true
			self.visible = true
			if global_vars.rolled == false:
				$Button.visible = true
				$ResourceTracker.visible = false
			if global_vars.playerNation == "UA":
				irrigular = global_vars.irResUA
				irrigularMob = global_vars.irMobUA
				regular = global_vars.reResUA
				regularMob = global_vars.reMobUA
			else:
				irrigular = global_vars.irResRU
				irrigularMob = global_vars.irMobRU
				regular = global_vars.reResRU
				regularMob = global_vars.reMobRU
				special = global_vars.specialRes
				specialMob = global_vars.specialMob
			showPieces()
			
		elif global_vars.reloadPieces:
			global_vars.reloadPieces = false
			delete_children(self)
			if global_vars.playerNation == "UA":
				irrigular = global_vars.irResUA
				irrigularMob = global_vars.irMobUA
				regular = global_vars.reResUA
				regularMob = global_vars.reMobUA
			else:
				irrigular = global_vars.irResRU
				irrigularMob = global_vars.irMobRU
				regular = global_vars.reResRU
				regularMob = global_vars.reMobRU
				special = global_vars.specialRes
				specialMob = global_vars.specialMob
			showPieces()
	else:
		if currentlyVisable:
			currentlyVisable = false
			self.visible = false
			delete_children(self)

func showPieces():
	irrigularToSummon = irrigular
	regularToSummon = regular
	specialToSummon = special
	for y in range(BOARD_DIMENTIONS.y):
		for x in range(BOARD_DIMENTIONS.x):
			if irrigularToSummon > 0:
				irrigularToSummon -= 1
				var new_tile
				if global_vars.playerNation == "UA":
					new_tile = load("res://Prefabs/Millitary/Ukraine/Irrgular.tscn").instance()
				else:
					new_tile = load("res://Prefabs/Millitary/Russia/Irrgular.tscn").instance()
				add_child(new_tile)
				new_tile.position = (Vector2((x+0.5)*60,(y+1.1)*60))
				
			elif regularToSummon > 0:
				regularToSummon -= 1
				var new_tile
				if global_vars.playerNation == "UA":
					new_tile = load("res://Prefabs/Millitary/Ukraine/Regular.tscn").instance()
				else:
					new_tile = load("res://Prefabs/Millitary/Russia/Regular.tscn").instance()
				add_child(new_tile)
				new_tile.position = (Vector2((x+0.5)*60,(y+1.1)*60))
			
			elif specialToSummon > 0:
				specialToSummon -= 1
				var new_tile = load("res://Prefabs/Millitary/Russia/Special.tscn").instance()
				add_child(new_tile)
				new_tile.position = (Vector2((x+0.5)*60,(y+1.1)*60))
	
	irrigularMobToSummon = irrigularMob
	regularMobToSummon = regularMob
	specialMobToSummon = specialMob
	for y in range(BOARD_DIMENTIONS.y):
		for x in range(BOARD_DIMENTIONS.x):
			if irrigularMobToSummon > 0:
				irrigularMobToSummon -= 1
				var new_tile
				if global_vars.playerNation == "UA":
					new_tile = load("res://Prefabs/Millitary/Ukraine/Irrgular.tscn").instance()
				else:
					new_tile = load("res://Prefabs/Millitary/Russia/Irrgular.tscn").instance()
				add_child(new_tile)
				new_tile.position = (Vector2((x+0.5)*60,(y+6.4)*60))
				new_tile.moblized = true
			
			elif regularMobToSummon > 0:
				regularMobToSummon -= 1
				var new_tile
				if global_vars.playerNation == "UA":
					new_tile = load("res://Prefabs/Millitary/Ukraine/Regular.tscn").instance()
				else:
					new_tile = load("res://Prefabs/Millitary/Russia/Regular.tscn").instance()
				add_child(new_tile)
				new_tile.position = (Vector2((x+0.5)*60,(y+6.4)*60))
				new_tile.moblized = true
				
			elif specialMobToSummon > 0:
				specialMobToSummon -= 1
				var new_tile = load("res://Prefabs/Millitary/Russia/Special.tscn").instance()
				add_child(new_tile)
				new_tile.position = (Vector2((x+0.5)*60,(y+6.4)*60))
				new_tile.moblized = true

static func delete_children(node):
	for n in node.get_children():
		if !(n is Label) and !(n is Button):
			node.remove_child(n)
			n.queue_free()


func _on_Button_pressed():
	$Button.visible = false
	$ResourceTracker.visible = true
	global_vars.rolling = true
