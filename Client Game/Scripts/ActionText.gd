extends RichTextLabel

onready var global_vars = get_node("/root/Global")

var textToShow = ""
var index = 0

var types = 0

var test = [1,2,3]


func _process(_delta):
	checkUpdate()
	

func checkUpdate():
	if index != global_vars.messages.size():
		textToShow += "[color="+global_vars.messages[index]["Color"]+"]"+"\n"+global_vars.messages[index]["Message"]+"[/color]"
		index += 1
		set_bbcode(textToShow)

func _on_Button_pressed():
	if types == 0:
		types = 1
		var textToSend = "Rolled 3 resource points on there moderate effort card"
		global_vars.message(textToSend,"Action")
	else:
		types = 0
		var textToSend = "Button Resetting"
		global_vars.message(textToSend,"Error")
