extends CanvasLayer

@export var gamemanager: LocalGameManager

func _on_to_main_menu_pressed():
	gamemanager.paused = false
	get_tree().change_scene_to_packed(load("res://scenes/main_menu.tscn"))


func _on_back_to_game_pressed():
	gamemanager.paused = false
