extends Sprite

onready var global_vars = get_node("/root/Global")
export var type := "mil"

var unknown = preload("res://Sprites/Effort/Uknown.png")
var minor = preload("res://Sprites/Effort/Minor.png")
var moderate = preload("res://Sprites/Effort/Moderate.png")
var major = preload("res://Sprites/Effort/Major.png")

var showing = false

func _process(_delta):
	if !showing:
		if global_vars.enemyDipCard != null:
			showAll()
	if showing:
		if global_vars.enemyDipCard == null:
			hideAll()
			
	if global_vars.phase == 2:
		setDip()
	if global_vars.phase == 3:
		setMil()
	if global_vars.phase == 4:
		setInf()
	if global_vars.phase == 5:
		setMil()
	if global_vars.showCeasefire:
		setDip()
	

func showAll():
	showing = true
	
	$EnemyMil.set_texture(unknown)
	$EnemyDip.set_texture(unknown)
	$EnemyInf.set_texture(unknown)
	
	$EnemyMil.visible = true
	$EnemyDip.visible = true
	$EnemyInf.visible = true

func hideAll():
	showing = false
	
	$EnemyMil.visible = false
	$EnemyDip.visible = false
	$EnemyInf.visible = false

func setMil():
	if global_vars.enemyMilCard == "Minor":
		$EnemyMil.set_texture(minor)
	if global_vars.enemyMilCard == "Moderate":
		$EnemyMil.set_texture(moderate)
	if global_vars.enemyMilCard == "Major":
		$EnemyMil.set_texture(major)

func setDip():
	if global_vars.enemyDipCard == "Minor":
		$EnemyDip.set_texture(minor)
	if global_vars.enemyDipCard == "Moderate":
		$EnemyDip.set_texture(moderate)
	if global_vars.enemyDipCard == "Major":
		$EnemyDip.set_texture(major)

func setInf():
	if global_vars.enemyInfCard == "Minor":
		$EnemyInf.set_texture(minor)
	if global_vars.enemyInfCard == "Moderate":
		$EnemyInf.set_texture(moderate)
	if global_vars.enemyInfCard == "Major":
		$EnemyInf.set_texture(major)
