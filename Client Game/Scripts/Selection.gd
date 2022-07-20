extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Area2D2_mouse_entered():
	$P_Card.visible = true


func _on_Area2D2_mouse_exited():
	$P_Card.visible = false
