extends Line2D

onready var Start = get_parent().get_node("Player/Vectorcreator/Arrow_holder/Position2D")
onready var End = get_parent().get_node("Player/Vectorcreator/Arrow/Positions/Arrow_end")
onready var Arrow = get_parent().get_node("Player/Vectorcreator/Arrow")

func _process(delta):
	if Arrow.state != Arrow.Idle:
		self.points[0] = Start.global_position
		self.points[1] = End.global_position
	else:
		self.points[0] = Vector2.ZERO
		self.points[1] = Vector2.ZERO
