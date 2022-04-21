extends NinePatchRect

onready var label = $Label
onready var counter = get_parent()
var label_size_x = 0
var increase_ratio = 0

func _ready():
	label_size_x = label.rect_size.x

func Label_resized():
	increase_ratio = (label.rect_size.x - label_size_x)
	counter.rect_min_size.x += increase_ratio
	self.rect_min_size.x += increase_ratio
	self.rect_size.x += increase_ratio
	label_size_x = label.rect_size.x
