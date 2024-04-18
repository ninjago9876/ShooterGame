extends Node

var musicoffset = 0

var savePath = "user://highscore.res"

var highscore: Highscore

var god_mode = false

func sync_save_data(level: int = 0, kills: int = 0):
	highscore = Highscore.new()
	if ResourceLoader.exists(savePath):
		highscore = ResourceLoader.load(savePath).duplicate(true)
	else:
		print("File not Found!")
	if not god_mode:
		highscore.update_highscore(level, kills)
	var save_result = ResourceSaver.save(highscore, savePath)
	if save_result != OK:
		print("Failed to save highscore: ", save_result)
