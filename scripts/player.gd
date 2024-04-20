extends CharacterBody2D
class_name Player

const SPEED = 100.0
const JUMP_VELOCITY = -400.0

@onready var animated_sprite_2d = $AnimatedSprite2D

var deg = 0

var running = false;

@export var health = 100
@export var max_health = 100
@export var gamemanager: LocalGameManager

func _physics_process(delta):
	if gamemanager.paused: return
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var action = "idle_"
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down").normalized()
	if direction != Vector2.ZERO:
		running = Input.is_action_pressed("run")
		velocity = direction * (SPEED + int(running) * 80)
		deg = int(round((float(rad_to_deg(direction.angle()))+90)/45)*45) % 360
		if (deg < -0): deg = 360 + deg
		action = "run_"
	else:
		velocity.x = move_toward(velocity.x, 0, 20)
		velocity.y = move_toward(velocity.y, 0, 20)
	if action == "run_": 
		if not $StepSFX.playing:
			$StepSFX.play(0)
	else:
		$StepSFX.stop()
	$StepSFX.pitch_scale = 1.35 + 0.5 * int(running)
	
	animated_sprite_2d.play(action + str(deg))

	move_and_slide()
	
	if (Input.get_last_mouse_velocity().length() > 0):
		$GunGimbal.look_at(get_global_mouse_position())
	var rightDir = Input.get_vector("aim_left", "aim_right", "aim_up", "aim_down")
	if not rightDir.is_zero_approx():
		$GunGimbal.global_rotation_degrees += rightDir.x * 135 * delta
	
	if health < 100:
		health += delta * 2

func _input(event):
		if event.is_action_pressed("fire"):
			%Gun.fire(event is InputEventJoypadMotion)


func checkDeath():
	if health < 0:
		gamemanager.end_game()

func _on_hitbox_body_entered(body):
	if body is Bullet && self:
		if not GlobalGameManager.god_mode:
			health -= 5
			var tween = create_tween()
			tween.tween_property($AnimatedSprite2D, "modulate", Color(1, 0.15, 0.17), 0.2)
			tween.tween_property($AnimatedSprite2D, "modulate", Color.WHITE, 0.02)
			checkDeath()
		else:
			var tween = create_tween()
			tween.tween_property($AnimatedSprite2D, "modulate", Color(0.18, 0.76, 0.94), 0.2)
			tween.tween_property($AnimatedSprite2D, "modulate", Color.WHITE, 0.02)
		body.queue_free()
