extends KinematicBody2D

onready var sprite = $Sprite
onready var vector_creator = $Vectorcreator
onready var left = $Positions/Left
onready var right = $Positions/Right
const Acceleration = 10
const Max_speed = 200
const Friction = 10
var velocity = Vector2.ZERO

func _physics_process(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
#		if input_vector.x > 0:
#			sprite.flip_h = true
#			vector_creator.global_position = right
#		else:
#			sprite.flip_h = false
#			vector_creator.global_position = right
		velocity += input_vector * Acceleration * delta
		velocity = velocity.clamped(Max_speed * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, Friction * delta)

	move_and_collide(velocity)
