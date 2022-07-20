extends Sprite

onready var global_vars = get_node("/root/Global")

func _process(_delta):
	if global_vars.pickingTurnType:
		if !visible:
			visible = true
			$MillitarySelected.visible = false
			$DiplomaticSelected.visible = false
	else:
		visible = false

func _on_MillitaryArea_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
		$MillitarySelected.visible = true
		$DiplomaticSelected.visible = false
		global_vars.millitaryTurn = true


func _on_DiplomaticArea_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
		$MillitarySelected.visible = false
		$DiplomaticSelected.visible = true
		global_vars.millitaryTurn = false
