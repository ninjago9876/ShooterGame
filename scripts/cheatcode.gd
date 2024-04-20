extends Node
class_name CheatCode

signal cheat_activated

@export var keys: Array[int] = [
	KEY_I, KEY_D, KEY_D, KEY_Q, KEY_D
]
@export var gamepad: Array[InputEvent] = []

@export var bufferTime: float = 1

var bufferTimer: float = 0
var buffer: Array[int] = []

var index = 0

var lastInputType: bool # 1 is controller 0 is keyboard

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	bufferTimer -= delta
	if bufferTimer < 0:
		index = 0
	if (index == keys.size() and lastInputType == false) or (index == gamepad.size() and lastInputType == true):
		index = 0
		cheat_activated.emit()
		return

func _input(event):
	if index < keys.size() and Input.is_key_pressed(keys[index]):
		index += 1
		bufferTimer = bufferTime
		lastInputType = 0
	if event.is_match(gamepad[index], false) and event.is_released():
		index += 1
		bufferTimer = bufferTime
		lastInputType = 1
	
