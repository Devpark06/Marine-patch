extends Node

onready var Arrow = get_parent().get_node("Player/Vectorcreator/Arrow")
onready var Garbage_spawner = get_parent().get_parent()
var Minimap_icon = "garbage"

func _enter_tree():
	Global.Total_garbage_count += 1

func hit():
	var index = get_index()
	Garbage_spawner.despawn(index)
