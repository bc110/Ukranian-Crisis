extends RichTextLabel


onready var global_vars = get_node("/root/Global")

export var valueName := "RP"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(_delta):
	if valueName == "RP":
		text = String(global_vars.RPToUse) + " RP"
	
	if valueName == "PP":
		text = String(global_vars.PPToUse) + " PP"
	
