extends Sprite

onready var global_vars = get_node("/root/Global")

func _process(_delta):
	if global_vars.showDiplomatic:
		if !visible:
			visible = true
			$Button.visible = true
	else:
		visible = false

	if !global_vars.rolled:
		if global_vars.turnPlayer:
				$Button.visible = true
	
	if global_vars.rolled:
		$SubTitle2.text = "You have "+str(global_vars.playerDipScore)+" resource points to spend!"
	else:
		$SubTitle2.text = "Please roll for resource points!"


func _on_Button_pressed():
	global_vars.rolling = true
	global_vars.rolled = true
	$Button.visible = false
