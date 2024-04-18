extends CanvasLayer

@export var gamemanager: LocalGameManager

func _on_to_main_menu_pressed():
	gamemanager.end_game()

func _on_back_to_game_pressed():
	gamemanager.paused = false
