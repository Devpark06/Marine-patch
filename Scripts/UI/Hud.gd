extends Control

onready var Garbage_counter = $Container/Counters/Garbage_counter
onready var Garbage_counter_label = Garbage_counter.get_node("Label")
onready var Coin_counter = $Container/Counters/Coin_counter
onready var Coin_counter_label = Coin_counter.get_node("Label")
onready var Pause_menu = $PauseLayer/PauseMenu
onready var Win_screen = get_node("WinLooseLayer/WinScreen")
onready var Win_star1 = Win_screen.get_node("NinePatchRect/Star1")
onready var Win_star2 = Win_screen.get_node("NinePatchRect/Star2")
onready var Win_star3 = Win_screen.get_node("NinePatchRect/Star3")
onready var Win_screen_coins = Win_screen.get_node("NinePatchRect/VBoxContainer/HBoxContainer/Label")
onready var Loose_screen = get_node("WinLooseLayer/LooseScreen")

func _ready():
	change_text()

func change_text():
	Garbage_counter_label.text = "%s / %s" % [Global.Garbage_collected,Global.Total_garbage_count]
	Coin_counter_label.text = str(Global.Coin_collected)

func scale_element(tween_node, element, animtime, animtype, easetype = Tween.EASE_OUT):
	tween_node.interpolate_property(
		element,
		"rect_scale",
		Vector2(0, 0),
		Vector2(1, 1),
		animtime,
		animtype,
		easetype)
	tween_node.start()

func show_gameover(type, stars = 0):
	if type == "win":
		Win_screen.visible = true
		if stars == 1:
			Win_star1.visible = true
			scale_element($Tween1, Win_star1, 0.9, Tween.TRANS_ELASTIC)
			yield(get_tree().create_timer(1.0), "timeout")
		elif stars == 2:
			Win_star1.visible = true
			scale_element($Tween1, Win_star1, 0.9, Tween.TRANS_ELASTIC)
			yield(get_tree().create_timer(1.0), "timeout")
			Win_star2.visible = true
			scale_element($Tween2, Win_star2, 0.9, Tween.TRANS_ELASTIC)
			yield(get_tree().create_timer(1.0), "timeout")
		elif stars == 3:
			Win_star1.visible = true
			scale_element($Tween1, Win_star1, 0.9, Tween.TRANS_ELASTIC)
			yield(get_tree().create_timer(1.0), "timeout")
			Win_star2.visible = true
			scale_element($Tween2, Win_star2, 0.9, Tween.TRANS_ELASTIC)
			yield(get_tree().create_timer(1.0), "timeout")
			Win_star3.visible = true
			scale_element($Tween3, Win_star3, 0.9, Tween.TRANS_ELASTIC)
			yield(get_tree().create_timer(1.0), "timeout")
		Win_screen_coins.text = "+" + str(Global.coins)
	elif type == "loose":
		Loose_screen.visible = true

func PauseButton_pressed():
	get_tree().paused = true
	Pause_menu.visible = true

func ResumeButton_pressed():
	get_tree().paused = false
	Pause_menu.visible = false

func RestartButton_pressed():
	get_tree().paused = false
	Pause_menu.visible = false
	get_tree().reload_current_scene()
	Global.reset()
	change_text()

func HomeButton_pressed():
	pass
