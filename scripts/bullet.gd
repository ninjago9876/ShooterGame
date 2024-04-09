extends RigidBody2D
class_name Bullet

var time = 0

var despawn_time = 0.5

func _process(delta):
	time += delta
	if time > despawn_time:
		queue_free()

func _on_body_entered(_body):
	if time > 0.05:
		queue_free()
