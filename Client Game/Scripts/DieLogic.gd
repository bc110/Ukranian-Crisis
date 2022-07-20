extends Node2D

var t = Timer.new()

var d1Texture = preload("res://Sprites/Die/d1.png")
var d2Texture = preload("res://Sprites/Die/d2.png")
var d3Texture = preload("res://Sprites/Die/d3.png")
var d4Texture = preload("res://Sprites/Die/d4.png")
var d5Texture = preload("res://Sprites/Die/d5.png")
var d6Texture = preload("res://Sprites/Die/d6.png")

var rolls = 30
var delay = 0.05

var value = 0

func _ready():
	randomize()

func rollDie():
	
	$Sprite2.visible = false
	
	#Makes animation
	for _x in range(0,rolls):
		yield(get_tree().create_timer(delay), "timeout")
		var tempValue = randi()%6+1
		switchTexture(randi()%6+1)
		
	#Actual Roll
	yield(get_tree().create_timer(delay), "timeout")
	value = randi()%6+1
	switchTexture(value)
	
	#Show if above 4, a hit in battles
	if value >= 4:
		$Sprite2.visible = true
	

func switchTexture(num):
	if num == 1:
		$Sprite.set_texture(d1Texture)
	elif num == 2:
		$Sprite.set_texture(d2Texture)
	elif num == 3:
		$Sprite.set_texture(d3Texture)
	elif num == 4:
		$Sprite.set_texture(d4Texture)
	elif num == 5:
		$Sprite.set_texture(d5Texture)
	elif num == 6:
		$Sprite.set_texture(d6Texture)
	
	
