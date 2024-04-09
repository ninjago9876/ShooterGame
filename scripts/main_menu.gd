extends Control

func _ready():
	GlobalGameManager.update_highscore()
	%Highscore.text = "Highscore:    Level " + str(GlobalGameManager.level) + "    :    " + str(GlobalGameManager.kills) + " Kills"
	if (get_tree().get_nodes_in_group("Enemy").size() > 0):
		for enemy in get_tree().get_nodes_in_group("Enemy"):
			enemy.queue_free()

func _on_exit_button_pressed():
	get_tree().quit()

func _on_play_button_pressed():
	get_tree().get_nodes_in_group("Enemy").all(queue_free)
	get_tree().change_scene_to_packed(load("res://scenes/game.tscn"))
