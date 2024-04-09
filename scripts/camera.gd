extends Camera2D

var offsetTarget: Vector2

@export var mouseLookFactor: float = 2
@export var mouseLookSpeed: float = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	offsetTarget = (get_local_mouse_position() / 10) * mouseLookFactor
	offset -= ((offset - offsetTarget) / 10) * mouseLookSpeed
