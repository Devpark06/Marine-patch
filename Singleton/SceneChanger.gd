extends CanvasLayer

signal scene_changed()

onready var animation_player = $AnimationPlayer
onready var black = $Control/Black

func change_scene(path, animation = "fade", delay = 0.5):
	yield(get_tree().create_timer(delay), "timeout")
	animation_player.play(animation)
	yield(animation_player, "animation_finished")
	get_tree().change_scene(path)
	animation_player.play_backwards(animation)
	yield(animation_player, "animation_finished")
	emit_signal("scene_changed")
