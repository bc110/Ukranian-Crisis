extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_DipSelect_mouse_entered():
	$P_Card.visible = true


func _on_DipSelect_mouse_exited():
	$P_Card.visible = false
