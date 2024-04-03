extends RigidBody2D
class_name Bullet

var time = 0

func _process(delta):
	time += delta
	if delta > 5:
		queue_free()

func _on_body_entered(body):
	if (body is TileMap):
		queue_free()
