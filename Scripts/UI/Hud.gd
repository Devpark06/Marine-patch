extends Control

onready var Garbage_counter = $Counters/Garbage_counter
onready var Garbage_counter_label = Garbage_counter.get_node("Label")
onready var Goin_counter = $Counters/Coin_counter
onready var Pause_menu = $PauseLayer/PauseMenu
var New_pause_state

func _ready():
	change_text()

func change_text():
	Garbage_counter_label.text = "%s / %s" % [Global.Garbage_collected,Global.Total_garbage_count]

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
