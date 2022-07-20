extends Sprite

onready var global_vars = get_node("/root/Global")

export var value := 1
export var valueName := "PPLable"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
		if get_rect().has_point(to_local(event.position)):
			if global_vars.showPointSelector:
				if valueName == "PPLable":
					if ((global_vars.PPToUse + value)>=0) and ((global_vars.PPToUse + value)<=global_vars.playerPrestege):
						global_vars.PPToUse += value
				elif valueName == "RPLable":
					if ((global_vars.RPToUse + value)>=global_vars.MinRP) and ((global_vars.RPToUse + value)<=global_vars.playerDipScore):
						global_vars.RPToUse += value
