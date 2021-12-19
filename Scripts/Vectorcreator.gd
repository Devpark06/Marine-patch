extends Area2D

signal vector_created(vector)
export var maximum_lenght = 200
var touch_down = false
var position_start = Vector2.ZERO
var position_end = Vector2.ZERO
var vector = Vector2.ZERO
	
func _draw():
	draw_line(position_start - global_position,(position_end - global_position),Color.blueviolet,8)
	draw_line(position_start - global_position,(position_start - global_position + vector),Color.red,16)

func reset():
	position_start = Vector2.ZERO
	position_end = Vector2.ZERO
	vector = Vector2.ZERO
	update()
	
func _input(event):		
	if event.is_action_released("ui_touch"):
		touch_down = false
		emit_signal("vector_created", vector)
		reset()
	
	if not touch_down:
		return
	
	if event is InputEventMouseMotion:
		position_end = event.position
		vector = -(position_end - position_start).clamped(maximum_lenght)
		update()

func on_Vectorcreator_input_event(_viewport, event, _shape_idx):#connected to input vector signal on area2d
	if event.is_action_pressed("ui_touch"):
		touch_down = true
		position_start = event.position
