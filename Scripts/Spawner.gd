extends Node2D

signal spawned(spawning)
export(PackedScene) var spawnscene

func spawn():
	var spawning = spawnscene.instance()
	add_child(spawning)
	spawning.set_as_top_level()
	spawning.global_position = self.glopal_position
	emit_signal("spawned",spawning)
	return spawning
