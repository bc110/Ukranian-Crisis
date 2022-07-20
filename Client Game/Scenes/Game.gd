extends Node2D
class_name Board

const BOARD_DIMENTIONS = Vector2(2,2)

func _ready():
	generate_tiles()
	
func generate_tiles() -> void:
	for x in range(BOARD_DIMENTIONS.x):
		for y in range(BOARD_DIMENTIONS.y):
			var new_tile = load("res://Prefabs/BoardTile.tscn").instance()
			add_child(new_tile)
			new_tile.position = (Vector2(x+0.25,y+0.25)*128)
			
