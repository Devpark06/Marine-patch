extends Node

var got_hit = false
var Arrow = get_parent().get_node("Player/Vectorcreator/Arrow")

func _enter_tree():
	Global.Total_garbage_count += 1
	
func hit():
	self.queue_free()
	got_hit = true
