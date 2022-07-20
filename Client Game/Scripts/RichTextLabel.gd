extends RichTextLabel


# Declare member variables here. Examples:
export var type := "Military"
onready var global_vars = get_node("/root/Global")

# Called when the node enters the scene tree for the first time.
func _ready():
	text = "Hello"


func _process(_delta):
	if type == "Military":
		if global_vars.playerMilScore == null:
			text = "Select Effort"
		else:
			text = String(global_vars.playerMilScore) + " Points"
	
	elif type == "Diplomatic":
		if global_vars.playerDipScore == null:
			text = "Select Effort"
		else:
			text = String(global_vars.playerDipScore) + " Points"
	
	elif type == "Information":
		if global_vars.playerInfScore == null:
			text = "Select Effort"
		else:
			text = String(global_vars.playerInfScore) + " Points"
