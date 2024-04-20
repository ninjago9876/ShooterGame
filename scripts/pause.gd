extends CanvasLayer

@export var gamemanager: LocalGameManager

func _process(delta):
	if not visible: return
	if Input.is_action_just_pressed("ui_up"):
		$Panel/BackToGame.grab_focus()
	if Input.is_action_just_pressed("ui_down"):
		$Panel/ToMainMenu.grab_focus()

func _on_to_main_menu_pressed():
	gamemanager.end_game()

func _on_back_to_game_pressed():
	gamemanager.paused = false
