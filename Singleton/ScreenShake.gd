extends Node

const TRANS = Tween.TRANS_SINE
const EASE = Tween.EASE_IN_OUT
var amplitude = 0
var priority = 0
var shake_hud = false
var camera = null
var hud = null

func _ready():
	if get_tree().has_group("Camera"):
		for i in get_tree().get_nodes_in_group("Camera"):
			if i.current:
				camera = i
			else:
				pass
	if get_tree().has_group("HudLayer"):
		for i in get_tree().get_nodes_in_group("HudLayer"):
			hud = i

func start(duration = 0.2, frequency = 15, amplitude = 16, priority = 0, shake_hud = false):
	if priority >= self.priority:
		_ready()
		self.shake_hud = shake_hud
		self.priority = priority
		self.amplitude = amplitude
		$duration.wait_time = duration
		$frequency.wait_time = 1 / float(frequency)
		$duration.start()
		$frequency.start()
		new_shake()

func new_shake():
	var rand = Vector2()
	rand.x = rand_range(-amplitude, amplitude)
	rand.y = rand_range(-amplitude, amplitude)
	
	if shake_hud:
		$ShakeTween1.interpolate_property(camera, "offset", camera.offset, rand, $frequency.wait_time)
		$ShakeTween2.interpolate_property(hud, "offset", hud.offset, rand * 0.2, $frequency.wait_time)
		$ShakeTween1.start()
		$ShakeTween2.start()
	else:
		$ShakeTween1.interpolate_property(camera, "offset", camera.offset, rand, $frequency.wait_time)
		$ShakeTween1.start()

func reset():
	$ShakeTween1.interpolate_property(camera, "offset", camera.offset, Vector2(), $frequency.wait_time)
	$ShakeTween2.interpolate_property(hud, "offset", hud.offset, Vector2(), $frequency.wait_time)
	$ShakeTween1.start()
	$ShakeTween2.start()
	priority = 0

func frequency_timeout():
	new_shake()

func duration_timeout():
	reset()
	$frequency.stop()
