extends KinematicBody2D

enum{
	Floating
	In_water
	Out_of_water
}

onready var Launch_area = $LaunchArea
onready var Arrow = Launch_area.get_node("Arrow")
onready var Arrow_holder = Launch_area.get_node("Arrow_holder")
onready var Waterbody = get_parent().get_node("Water")
onready var Hud = get_parent().get_node("HudLayer/Hud")
onready var Joypad = Hud.get_node("Joypad_control/Joypad/Joypad_button")
const Acceleration = 10
const Max_speed = 200
const Friction = 10
var gravity = 35
var max_y_speed = 450
var motion = Vector2.ZERO
var velocity = Vector2.ZERO
var state = Out_of_water
var water_force = 300.0
var water_width = 200.0

func _physics_process(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	if input_vector == Vector2.ZERO:
		input_vector = Joypad.get_value()
	
	if state == Out_of_water:
		Arrow.global_position = Arrow_holder.global_position
		if AudioServer.get_bus_effect_count(SoundEffect.SoundEffect_index) != 0:
			AudioServer.remove_bus_effect(SoundEffect.SoundEffect_index, 0)
			SoundEffect.change_pitch("Submarine", 0.8, 2 * delta)
		gravity = 35
		max_y_speed = 450
		motion.y += gravity
		motion.y = clamp(motion.y, -max_y_speed, max_y_speed)
		motion = move_and_slide(motion)
	elif state == In_water:
		var effect = AudioEffectLowPassFilter.new()
		effect.cutoff_hz = 1000
		effect.resonance = 0.5
		effect.db = 6
		AudioServer.add_bus_effect(SoundEffect.SoundEffect_index, effect, 0)
	else:
		if AudioServer.get_bus_effect_count(SoundEffect.SoundEffect_index) != 0:
			AudioServer.remove_bus_effect(SoundEffect.SoundEffect_index, 0)
			SoundEffect.change_pitch("Submarine", 0.8, 2 * delta)
	
	if input_vector != Vector2.ZERO and Arrow.state == Arrow.Idle:
		if SoundEffect.is_playing("Submarine") == false:
			SoundEffect.play("Submarine")
		else:
			SoundEffect.change_pitch("Submarine", 0.2, 2 * delta)
		velocity += input_vector * Acceleration * delta
		velocity = velocity.clamped(Max_speed * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, Friction * delta)
		SoundEffect.change_pitch("Submarine", 0.1, 2 * delta)
	
	move_and_collide(velocity)

func Water_body_entered(body):
	if body.is_in_group("Player"):
		state = In_water
		Waterbody.apply_force(global_position, water_force * Vector2.DOWN, water_width)
		SoundEffect.play("Splash")

func Water_body_exited(body):
	if body.is_in_group("Player"):
		state = Out_of_water
