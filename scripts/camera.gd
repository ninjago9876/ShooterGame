extends Camera2D

var offsetTarget: Vector2

@export var mouseLookFactor: float = 2
@export var mouseLookSpeed: float = 1
@export var orbitSize: float = 0

var t = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	t+=delta
	offsetTarget = (get_local_mouse_position() / 10) * mouseLookFactor
	offsetTarget += Vector2.from_angle(t)*orbitSize
	offset -= ((offset - offsetTarget) / 10) * mouseLookSpeed
