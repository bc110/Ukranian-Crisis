extends Sprite

onready var global_vars = get_node("/root/Global")

var moblized = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
		if get_rect().has_point(to_local(event.position)):
			if global_vars.showMillitary:
				if global_vars.turnPlayer:
					if global_vars.rolled:
						if global_vars.playerMilScore > 0:
							if !get_owner().moblized:
								global_vars.moblizeUnit("special",global_vars.playerNation)
								var moveData = {"MoveType":"Mobilize","Unit":"regular"}
								Server.SendMove(moveData,get_instance_id())
								global_vars.message("Mobilized Special Forces","Action")
							else:
								global_vars.selectUnit("special")
