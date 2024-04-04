extends CharacterBody2D

@export var player: Node2D
@export var speed: float

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	velocity = to_local($NavigationAgent2D.get_next_path_position()).normalized() * speed
	move_and_slide()

func make_path():
	$NavigationAgent2D.target_position = player.global_position


func _on_timer_timeout():
	make_path()
