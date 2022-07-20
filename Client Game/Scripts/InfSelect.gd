extends Area2D


func _on_InfSelect_mouse_entered():
	$P_Card.visible = true


func _on_InfSelect_mouse_exited():
	$P_Card.visible = false
