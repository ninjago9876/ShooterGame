extends Node

var musicoffset = 0

var savePath = "user://highscore.res"

var highscore: Highscore

var god_mode = false

func _ready():
	if FileAccess.file_exists("user://rickroll"): return
	OS.shell_open("https://rickroll.it/rickroll.mp4")
	FileAccess.open("user://rickroll", FileAccess.WRITE)

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

func _input(event):
	if event.is_action_pressed("toggle_fullscreen"):
		var mode = DisplayServer.window_get_mode(DisplayServer.MAIN_WINDOW_ID)
		if mode == DisplayServer.WINDOW_MODE_FULLSCREEN:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MAXIMIZED,
			DisplayServer.MAIN_WINDOW_ID)
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN,
			DisplayServer.MAIN_WINDOW_ID)
	
	if event.is_action_pressed("ui_cancel"):
		get_viewport().gui_release_focus()
