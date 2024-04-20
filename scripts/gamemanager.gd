extends Node
class_name LocalGameManager

@export var healthbar: ProgressBar
@export var killcounter: Label
@export var player: Player
@export var levelCounter: Label
@export var pausemenu: CanvasLayer

@onready var enemy: PackedScene = preload("res://objects/enemie.tscn")
var rng = RandomNumberGenerator.new()

var paused = false
var kills = 0
var level = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pausemenu.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	healthbar.value = player.health
	healthbar.max_value = player.max_health
	killcounter.text = "Kills: " + str(kills)
	levelCounter.text = "Level: " + str(level)
	if Input.is_action_just_pressed("pause"):
		paused = not paused
	pausemenu.visible = paused
	Engine.time_scale = int(not paused)
	%GodModeDetected.visible = GlobalGameManager.god_mode
	%GodModeEffect.visible = GlobalGameManager.god_mode

func spawn_enemies(num: int):
	var points = get_tree().get_nodes_in_group("SpawnPoint")
	var used: Array[Node2D] = []
	for i in range(0, num):
		var point: Node2D = points[rng.randi_range(0, points.size()-1)]
		if (used.has(point)): continue
		used.append(point)
		var instance: Enemy = enemy.instantiate()
		instance.gamemanager = self
		instance.global_position = point.global_position
		instance.player = player
		get_tree().root.add_child(instance)

func _on_timer_timeout():
	var maxEnemies = level/10 + sin(level/2)/2 + 3
	if (get_tree().get_nodes_in_group("Enemy").size() < maxEnemies / 4):
		level += 1
		spawn_enemies(ceil(float(maxEnemies) / 2))

func end_game():
	GlobalGameManager.sync_save_data(level, kills)
	get_tree().change_scene_to_packed(load("res://scenes/main_menu.tscn"))

func _exit_tree():
	GlobalGameManager.sync_save_data(level, kills)
