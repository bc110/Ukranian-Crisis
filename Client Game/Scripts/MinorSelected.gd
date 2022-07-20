extends Sprite

onready var global_vars = get_node("/root/Global")
export var type := "mil"

var minor = preload("res://Sprites/Effort/Minor.png")
var moderate = preload("res://Sprites/Effort/Moderate.png")
var major = preload("res://Sprites/Effort/Major.png")

var cardType = null

func _process(_delta):
	if type == "mil":
		if global_vars.playerMilCard != null:
			visible = true
			cardType = global_vars.playerMilCard
		else:
			cardType = null
			visible = false
			
			
	if type == "dip":
		if global_vars.playerDipCard != null:
			cardType = global_vars.playerDipCard
			visible = true
		else:
			cardType = null
			visible = false
			
			
	if type == "inf":
		if global_vars.playerInfCard != null:
			cardType = global_vars.playerInfCard
			visible = true
		else:
			cardType = null
			visible = false

	if cardType != null:
		if cardType == "Minor":
			set_texture(minor)
		elif cardType == "Moderate":
			set_texture(moderate)
		elif cardType == "Major":
			set_texture(major)
