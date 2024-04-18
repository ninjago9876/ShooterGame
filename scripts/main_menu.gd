extends Control

func _ready():
	GlobalGameManager.sync_save_data()
	%Highscore.text = "Level: " + str(GlobalGameManager.highscore.level) + "     Kills: " + str(GlobalGameManager.highscore.kills)
	remove_enemies()

func _process(delta):
	%GodMode.visible = GlobalGameManager.god_mode
	%GodModeEffect.visible = GlobalGameManager.god_mode

func remove_enemies():
	if (get_tree().get_nodes_in_group("Enemy").size() > 0):
		for enemy in get_tree().get_nodes_in_group("Enemy"):
			enemy.queue_free()

func _on_exit_button_pressed():
	get_tree().quit()

func _on_play_button_pressed():
	get_tree().get_nodes_in_group("Enemy").all(queue_free)
	get_tree().change_scene_to_packed(load("res://scenes/game.tscn"))


func _on_cheat_code_cheat_activated():
	GlobalGameManager.god_mode = not GlobalGameManager.god_mode
