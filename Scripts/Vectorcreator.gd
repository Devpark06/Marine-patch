extends Area2D

signal vector_created(vector)
onready var Arrow = $Arrow
onready var Arrow_holder = $Arrow_holder
var maximum_lenght = 200
var touch_down = false
var position_start = Vector2.ZERO
var position_end = Vector2.ZERO
var vector = Vector2.ZERO
var vector_angle = 0 
var self_pos = Arrow.global_position
var	target_pos = Arrow_holder.global_position
var	distance_to_arrow = self_pos.distance_to(target_pos)
var mouse_entered

func _draw():
	draw_line(position_start - global_position,(position_end - global_position),Color.blueviolet,8)
	draw_line(position_start - global_position,(position_start - global_position + vector),Color.red,16)

func reset():
	position_start = Vector2.ZERO
	position_end = Vector2.ZERO
	vector = Vector2.ZERO
	update()

func mouse_entered():
	mouse_entered = true

func mouse_exited():
	mouse_entered = false

func _input(event):
	#if mouse_entered:
		if event.is_action_released("ui_touch"):
			touch_down = false
			emit_signal("vector_created", vector)
			reset()
		
		if not touch_down:
			return
		
		if event is InputEventMouseMotion:
			position_end = get_viewport_transform().xform_inv(event.position)
			vector = -(position_end - position_start).clamped(maximum_lenght)
			vector_angle = rad2deg(vector.angle()) + 180
			Arrow_holder.rotation_degrees = vector_angle
			Arrow.rotation_degrees = vector_angle
			update()

func on_Vectorcreator_input_event(_viewport, event, _shape_idx):
	if event.is_action_pressed("ui_touch"):
		touch_down = true
		position_start = get_viewport_transform().xform_inv(event.position)

func on_vector_created(impulse):
	Arrow.look_at(Arrow_holder.global_position)
	Arrow.launch(impulse)
	Arrow.setup()

func on_body_entered(body):
	if body.is_in_group("Arrow"):
		if Arrow.state == Arrow.Returning:
			Arrow.return_to()
