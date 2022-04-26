extends Control

func _ready():
	pass

func _on_Button_button_down():
	SceneChanger.change_scene("res://Scenes/Levels/Level1.tscn")

func _on_Button2_button_down():
	get_tree().quit()
