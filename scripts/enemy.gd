extends CharacterBody2D
class_name Enemy

@export var player: Node2D
@export var SPEED: float

var running: bool

@export var health: int = 100

var rng = RandomNumberGenerator.new()
var gamemanager: LocalGameManager

# Called when the node enters the scene tree for the first time.
func _ready():
	$ShootTimer.start(rng.randf_range(0, 1))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	if not self or not player: return
	velocity = to_local($NavigationAgent2D.get_next_path_position()).normalized() * SPEED
	
	move_and_slide()
	var action = "idle_"
	var deg = 0
	if velocity != Vector2.ZERO:
		running = Input.is_action_pressed("run")
		action = "run_"
	
	$GunGimbal.global_rotation = to_local(player.global_position).normalized().angle()
	deg = int(round((float(rad_to_deg($GunGimbal.global_rotation))+90)/45)*45) % 360
	if (deg < -0): deg = 360 + deg
	$AnimatedSprite2D.play(action + str(deg))
	
	$HealthBar.value = health
	

func make_path():
	if not self or not player: return
	$NavigationAgent2D.target_position = player.global_position
	if to_local(player.global_position).length() < 200:
		$NavigationAgent2D.target_position = player.global_position - to_local(player.global_position).normalized()*200

func _on_timer_timeout():
	make_path()

func checkDeath():
	if health < 0 && player:
		queue_free()
		gamemanager.kills += 1

func _on_hitbox_body_entered(body):
	if body is Bullet && self:
		health -= 20
		var tween = create_tween()
		tween.tween_property($AnimatedSprite2D, "modulate", Color(1, 0.15, 0.17), 0.2)
		tween.tween_property($AnimatedSprite2D, "modulate", Color.WHITE, 0.02)
		checkDeath()
		body.queue_free()


func _on_shoot_timer_timeout():
	$GunGimbal.global_rotation_degrees += rng.randf_range(-2, 2)
	$GunGimbal/Gun.fire()
