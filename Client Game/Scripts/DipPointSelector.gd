extends Container

onready var global_vars = get_node("/root/Global")

func _process(_delta):
	self.visible = global_vars.showPointSelector

