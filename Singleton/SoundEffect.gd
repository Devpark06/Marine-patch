extends Node2D

onready var Master_index = AudioServer.get_bus_index("Master")
onready var Music_index = AudioServer.get_bus_index("Music")
onready var Ambience_index = AudioServer.get_bus_index("Ambience")
onready var SoundEffect_index = AudioServer.get_bus_index("SoundEffect")
onready var UiSound_index = AudioServer.get_bus_index("UiSound")

func _ready():
	randomize()

func play(sfx = null, group = ""):
	randomize()
	if group == "":
		if sfx:
			get_node(sfx).play()
		else:
			var c = randi() % get_child_count()
			get_child(c).play()
	else:
		if sfx:
			get_node(group).get_node(sfx).play()

func is_playing(sfx):
	if sfx:
		if get_node(sfx).is_playing():
			return true
		else:
			return false
	else:
		return
		
func change_pitch(sfx, pitch, weight):
	if sfx:
		get_node(sfx).pitch_scale = lerp(get_node(sfx).pitch_scale, pitch, weight)
	else:
		pass
