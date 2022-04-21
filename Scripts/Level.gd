extends Node2D

onready var garbage_node = $Garbage_spawner/Garbage
onready var positions_node = $Garbage_spawner/Positions
onready var Hud = get_node("HudLayer/Hud")
var stars_collected = 0

func _ready():
	pass
	
func _process(_delta):
	if garbage_node.get_child_count() == 0:
		if Global.health >= 50:
			stars_collected += 1
		if Global.health >= 20:
			stars_collected += 1
		if Global.Coin_collected == 0: #Later to be replaced
			stars_collected += 1
		Hud.show_gameover("win", stars_collected)
	elif Global.health == 0:
		Hud.show_gameover("loose")
