extends RigidBody2D

enum{
	Idle
	Launched
	Returning
}

signal Hit
onready var Parent = get_parent()
onready var Arrow_holder = Parent.get_node("Arrow_holder")
onready var Trash_sprite = $Trash
onready var Delay_timer = $Delay_for_pull
onready var hud = Parent.get_parent().get_parent().get_node("HudLayer/Hud")
var state = Idle
var distance = 0
var direction = Vector2.ZERO
var launch_force = 600
var return_force = 1000
var cycle = false
var hit = false

func launch(direction):
	self.apply_impulse(Vector2.ZERO, direction * launch_force)
	SoundEffect.play("ArrowLaunch", "Arrow")
	state = Launched

func setup():
	Delay_timer.start()

func return_to():
	self.linear_velocity = Vector2.ZERO
	self.angular_velocity = 0
	self.sleeping = true
	self.global_position = Arrow_holder.global_position
	self.global_rotation = lerp_angle(self.global_rotation, Arrow_holder.global_rotation, 1)
	if hit:
		$Tween.interpolate_property(
			Trash_sprite,
			"scale",
			Trash_sprite.scale,
			Vector2(0,0),
			0.7,
			Tween.TRANS_CUBIC,
			Tween.EASE_OUT
		)
		$Tween.start()
	self.global_position = Arrow_holder.global_position
	self.global_rotation = Arrow_holder.global_rotation
	state = Idle
	hit = false

func on_body_entered(body):
	if body.is_in_group("Trash") and state == Launched and not hit:
		Trash_sprite.texture = body.get_node("Sprite").texture
		Trash_sprite.scale = body.get_node("Sprite").scale
		hit =  true
		emit_signal("Hit")
		Global.Garbage_collected +=1
		hud.change_text()
		body.hit()

func Return_when_hit():
	if hit:
		direction = global_position.direction_to(Arrow_holder.global_position)
		self.apply_central_impulse(direction * return_force)
		state = Returning
		Delay_timer.stop()

func Return_when_timeup():
	direction = global_position.direction_to(Arrow_holder.global_position)
	self.apply_central_impulse(direction * return_force)
	state = Returning
