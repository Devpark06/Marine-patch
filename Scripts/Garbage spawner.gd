extends Node2D

var packed_scenes = [
	preload("res://Scenes/Garbage/Astronout_helmet.tscn"),
	preload("res://Scenes/Garbage/Book.tscn"),
	preload("res://Scenes/Garbage/Boots.tscn"),
	preload("res://Scenes/Garbage/Cactus_pot.tscn"),
	preload("res://Scenes/Garbage/Calculator.tscn"),
	preload("res://Scenes/Garbage/Chainsaw.tscn"),
	preload("res://Scenes/Garbage/Clamper.tscn"),
	preload("res://Scenes/Garbage/Coffe_cup.tscn"),
	preload("res://Scenes/Garbage/Glass.tscn"),
	preload("res://Scenes/Garbage/Honey_Jar.tscn"),
	preload("res://Scenes/Garbage/Lamp.tscn"),
	preload("res://Scenes/Garbage/Light_bulb.tscn"),
	preload("res://Scenes/Garbage/Men_bag.tscn"),
	preload("res://Scenes/Garbage/Microwave_oven.tscn"),
	preload("res://Scenes/Garbage/News_paper.tscn"),
	preload("res://Scenes/Garbage/Paper_bag.tscn"),
	preload("res://Scenes/Garbage/Pepsi_can.tscn"),
	preload("res://Scenes/Garbage/Pillow.tscn"),
	preload("res://Scenes/Garbage/Plastic_bottle.tscn"),
	preload("res://Scenes/Garbage/Plastic_cup.tscn"),
	preload("res://Scenes/Garbage/Popcorn_cup.tscn"),
	preload("res://Scenes/Garbage/Shield.tscn"),
	preload("res://Scenes/Garbage/Sofa1.tscn"),
	preload("res://Scenes/Garbage/Sofa2.tscn"),
	preload("res://Scenes/Garbage/Wine_bottle.tscn"),
	preload("res://Scenes/Garbage/Wine_glass.tscn"),
	preload("res://Scenes/Garbage/Women_bag.tscn"),
	preload("res://Scenes/Garbage/Wood1.tscn"),
	preload("res://Scenes/Garbage/Wood2.tscn")
]

signal spawned()
signal despawned(target)
onready var Positions_node = $Positions
onready var Garbage_node = $Garbage
onready var Tween_node = $Tween
var tween_time = 0.9
var No_of_positions
var location = Vector2()

func _ready():
	No_of_positions = Positions_node.get_child_count() 
	for i in No_of_positions:
		randomize()
		spawn(i)

func spawn(i):
	var x = randi() % packed_scenes.size()
	location = Positions_node.get_child(i).global_position
	var scene = packed_scenes[x].instance()
	scene.global_position = location
	Garbage_node.add_child(scene)
	
	Tween_node.interpolate_property(
		scene,
		"scale",
		Vector2(0,0),
		Vector2(1,1),
		tween_time,
		Tween.TRANS_CUBIC,
		Tween.EASE_OUT
	)
	Tween_node.start()

func despawn(index):
	var garbage_to_despawn = Garbage_node.get_child(index)
	garbage_to_despawn.queue_free()
	emit_signal("despawned", garbage_to_despawn)
