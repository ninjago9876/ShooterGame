extends Node

@export var music: AudioStreamPlayer2D

# Called when the node enters the scene tree for the first time.
func _ready():
	music.play(GlobalGameManager.musicoffset)

func _on_tree_exiting():
	GlobalGameManager.musicoffset = music.get_playback_position()
