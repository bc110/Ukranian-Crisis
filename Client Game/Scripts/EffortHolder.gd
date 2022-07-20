extends Sprite

# Declare member variables here. Examples:
onready var global_vars = get_node("/root/Global")
const BOARD_DIMENTIONS = Vector2(4,6)

# Called when the node enters the scene tree for the first time.
func _ready():
	generate_tiles()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	self.visible = global_vars.getHolder()
	
func generate_tiles() -> void:
	var minor = 12
	var moderate = 8
	var major = 4
	for y in range(BOARD_DIMENTIONS.y):
		for x in range(BOARD_DIMENTIONS.x):
			if moderate > 0:
				moderate -= 1
				var new_tile = load("res://Prefabs/ModerateEffort.tscn").instance()
				add_child(new_tile)
				new_tile.position = (Vector2((x-2)*140,(y-4)*64))
			elif minor > 0:
				minor -= 1
				var new_tile = load("res://Prefabs/MinorEffort.tscn").instance()
				add_child(new_tile)
				new_tile.position = (Vector2((x-2)*140,(y-4)*64))
			elif major > 0:
				major -= 1
				var new_tile = load("res://Prefabs/MajorEffort.tscn").instance()
				add_child(new_tile)
				new_tile.position = (Vector2((x-2)*140,(y-4)*64))
