extends Area2D

signal vector_created(vector)
var maximum_lenght = 200
var touch_down = false
var position_start = Vector2.ZERO
var position_end = Vector2.ZERO
var vector = Vector2.ZERO
var direction = Vector2.ZERO
export (NodePath) var ArrowHolder
export (NodePath) var ReturnPos
var Arrow_scene = preload("res://Scenes/Arrow.tscn")
var Arrow_launched = false
var Vector_angle = 0 
		
func _physics_process(delta):
	pass
	
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
		position_end = get_viewport_transform().xform_inv(event.position)
		vector = -(position_end - position_start).clamped(maximum_lenght)
		Vector_angle = vector.angle()
		$Arrow_holder.rotation = Vector_angle
		$Arrow.rotation = Vector_angle
		update()			

func on_Vectorcreator_input_event(_viewport, event, _shape_idx):
	if event.is_action_pressed("ui_touch"):
		touch_down = true
		position_start = get_viewport_transform().xform_inv(event.position)

func on_vector_created(impulse):
	$Arrow.look_at(get_global_mouse_position())
	$Arrow.launch(impulse)
	#Arrow_launched = true
	yield(get_tree().create_timer(5.0),"timeout")
	$Arrow.setup()
