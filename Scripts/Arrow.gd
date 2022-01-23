extends RigidBody2D

var launched = false
var hit = false
var Return = false
var rotate_arrow = false
var direction = Vector2.ZERO
export (NodePath) var ArrowHolder
export (NodePath) var ReturnPos
export (NodePath) var Vector_creator

func _integrate_forces(state):
	pass
	
func launch(impulse):
	launched = true 
	self.apply_impulse(Vector2.ZERO, impulse)
	
func setup():
	#return the arrow back to where fired
	pass
