extends Area2D

#var input_states = preload("res://scripts/input_states.gd")
#var click = input_states.new("click")
#onready var Hero = get_tree().get_root().get_node("/root/Node2D/Hero")
#onready var sprite = get_tree().get_root().get_node("/root/Node2D/Hero/Sprite")

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	#set_fixed_process(true)
	#self.get_global_mouse_pos()
	print("")


func _input_event(viewport, event, shape_idx):
	if event.type == InputEvent.MOUSE_BUTTON \
	and event.button_index == BUTTON_LEFT \
	and event.pressed:
		print("Clicked")
