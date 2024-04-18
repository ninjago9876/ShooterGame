extends Node
class_name CheatCode

signal cheat_activated

@export var keys: Array[int] = [
	KEY_I, KEY_D, KEY_D, KEY_Q, KEY_D
]

@export var bufferTime: float = 1

var bufferTimer: float = 0
var buffer: Array[int] = []

var index = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	bufferTimer -= delta
	if bufferTimer < 0:
		index = 0
	if index == keys.size():
		index = 0
		cheat_activated.emit()
		return
	if Input.is_key_pressed(keys[index]):
		index += 1
		bufferTimer = bufferTime
	
