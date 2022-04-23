extends Area2D

onready var Action_button = get_parent().get_parent().get_node("HudLayer/Hud/Action button")
onready var Action_button_label = Action_button.get_node("Label")
onready var Arrow = $Arrow
onready var Arrow_holder = $Arrow_holder
var garbage_on_screen = []
var vector_angle = 0

func _physics_process(_delta):
	if garbage_on_screen.size() == 0:
		Action_button.disabled = true
	else:
		Action_button.disabled = false

	if Action_button.disabled == true:
		Action_button_label.modulate.a = 0.53
	else:
		Action_button_label.modulate.a = 1

func on_body_entered(body):
	if body.is_in_group("Arrow"):
		if Arrow.state == Arrow.Returning:
			Arrow.return_to()

func Action_button_down():
	var target = null
	
	if garbage_on_screen.size() != 0:
		target = garbage_on_screen[0].global_position
	else:
		return
	
	var target_direction = Arrow.global_position.direction_to(target)
	vector_angle = rad2deg(Arrow.global_position.angle_to_point(target))
	Arrow_holder.rotation_degrees = vector_angle
	Arrow.rotation_degrees = vector_angle
	Arrow.launch(target_direction)
	Arrow.setup()

func on_screen_body_entered(body):
	if body.is_in_group("Trash"):
		garbage_on_screen.append(body)

func on_Screen_body_exited(body):
	if body.is_in_group("Trash"):
		garbage_on_screen.remove(garbage_on_screen.find(body))
