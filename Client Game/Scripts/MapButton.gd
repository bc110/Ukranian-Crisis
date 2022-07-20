extends Control

onready var global_vars = get_node("/root/Global")
func _on_Button_pressed():
	if global_vars.phase == 3:
		if global_vars.showMillitary == true:
			if global_vars.unitSelected == null:
				if global_vars.showingMap == false:
					global_vars.showMillitary = false
					global_vars.showingMap = true
		else:
			if global_vars.unitSelected == null:
				global_vars.showMillitary = true
				global_vars.showingMap = false
