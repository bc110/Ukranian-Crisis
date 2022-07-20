extends KinematicBody2D

onready var global_vars = get_node("/root/Global")

export var token := "US"
var currentPos = 1

export var Pos1 = 60
export var Pos2 = -20
export var Pos3 = -100

var targetPos = Pos1

func _ready():
	updatePos()
	position.y = targetPos
	
func _physics_process(_delta):
	updatePos()
	var velocity = Vector2.ZERO
	if global_vars.showDiplomatic:
		if round(position.y) == targetPos:
			position.y = targetPos
		elif targetPos < position.y:
			velocity.y -= 3.0
		else:
			velocity.y += 3.0
# warning-ignore:return_value_discarded
	move_and_slide(velocity*20)

func updatePos():
	if token == "US":currentPos = global_vars.USPos
	if token == "DE":currentPos = global_vars.DEPos
	
	if token == "GB":currentPos = global_vars.GBPos
	if token == "FR":currentPos = global_vars.FRPos
	
	if token == "RO":currentPos = global_vars.ROPos
	if token == "BY":currentPos = global_vars.BYPos
	if token == "PL":currentPos = global_vars.PLPos
	
	if currentPos == 1: targetPos = Pos1
	elif currentPos == 2: targetPos = Pos2
	elif currentPos == 3: targetPos = Pos3
