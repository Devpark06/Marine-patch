extends Node

export(String, "Book", "Calculator", "Can", "Glass",
 "Leather", "Metalic", "Newspaper", "Pillow",
 "Shopping bag", "Sofa", "Wood", "Plastic") var Impact_sound = null

onready var Garbage_spawner = get_parent().get_parent()
var Minimap_icon = "garbage"

func _enter_tree():
	Global.Total_garbage_count += 1

func hit():
	SoundEffect.play(Impact_sound + " " + "impact", "Impact")
	var index = get_index()
	Garbage_spawner.despawn(index)
