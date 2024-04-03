extends Node2D
class_name Gun

var bullet

@export var speed = 500

func fire():
	if ($AnimationPlayer.is_playing()): return
	$AnimationPlayer.play("fire_gun")
	$FireSFX.play(0)
	var bullet_instance: RigidBody2D = bullet.instantiate()
	bullet_instance.global_position = $BulletHole.global_position
	bullet_instance.global_rotation_degrees = $BulletHole.global_rotation_degrees+90
	bullet_instance.apply_central_impulse(
		Vector2.from_angle(deg_to_rad(bullet_instance.global_rotation_degrees)) * speed
	)
	get_tree().current_scene.add_child(bullet_instance)
	
	Input.start_joy_vibration(0, 1, 1, 0.2)

# Called when the node enters the scene tree for the first time.
func _ready():
	bullet = preload("res://objects/bullet.tscn")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
