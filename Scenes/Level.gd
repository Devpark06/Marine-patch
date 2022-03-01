extends Node2D

onready var garbage_node = $Garbage_spawner/Garbage
onready var positions_node = $Garbage_spawner/Positions
onready var Hud = get_node("HudLayer/Hud")

func _ready():
	pass
	
func _process(delta):
	if garbage_node.get_child_count() == 0:
		Hud.show_winscreen()
