extends Control

onready var Lifebar = $LifeBar
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
var Star_tween_type = Tween.TRANS_BOUNCE
var Star_tween_animtime = 0.5
var Star_tween_delay = 0.3 

func _ready():
	change_text()

func change_text():
	Garbage_counter_label.text = "%s / %s" % [Global.Garbage_collected,Global.Total_garbage_count]
	Coin_counter_label.text = str(Global.Coin_collected)
	Lifebar.value = Global.health

func scale_element(element, animtime, animtype, easetype = Tween.EASE_OUT):
	$Tween.interpolate_property(
		element,
		"rect_scale",
		Vector2(3, 3),
		Vector2(1, 1),
		animtime,
		animtype,
		easetype)
	$Tween.start()

func show_gameover(type, stars = 0):
	if type == "win":
		var playable = true
		if !SoundEffect.is_playing("Balloon", "GamOver") and playable:
			SoundEffect.play("Balloon", "GameOver")
			playable = false
		ScreenShake.start(0.8, 15, 20, 1, true)
		for child in $Confetti.get_children():
			child.emitting = true
		yield(get_tree().create_timer(1.2), "timeout")
		Win_screen.visible = true
		if stars == 1:
			Win_star1.visible = true
			scale_element(Win_star1, Star_tween_animtime, Star_tween_type)
			yield(get_tree().create_timer(Star_tween_delay), "timeout")
		elif stars == 2:
			Win_star1.visible = true
			scale_element(Win_star1, Star_tween_animtime, Star_tween_type)
			yield(get_tree().create_timer(Star_tween_delay), "timeout")
			Win_star2.visible = true
			scale_element(Win_star2, Star_tween_animtime, Star_tween_type)
			yield(get_tree().create_timer(Star_tween_delay), "timeout")
		elif stars == 3:
			Win_star1.visible = true
			scale_element(Win_star1, Star_tween_animtime, Star_tween_type)
			yield(get_tree().create_timer(Star_tween_delay), "timeout")
			Win_star2.visible = true
			scale_element(Win_star2, Star_tween_animtime, Star_tween_type)
			yield(get_tree().create_timer(Star_tween_delay), "timeout")
			Win_star3.visible = true
			scale_element(Win_star3, Star_tween_animtime, Star_tween_type)
			yield(get_tree().create_timer(Star_tween_delay), "timeout")
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
	SoundEffect.stop("Submarine")
	get_tree().paused = false
	Pause_menu.visible = false
	get_tree().reload_current_scene()
	Global.reset()
	change_text()

func HomeButton_pressed():
	SoundEffect.stop("Submarine")
	SceneChanger.change_scene("res://Scenes/UI/Main.tscn")
	get_tree().paused = false
	Global.reset()
