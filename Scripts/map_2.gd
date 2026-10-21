extends Node2D
var selected_tower : PackedScene = preload("res://Scenes/tower_1.tscn")
var enemy_to_spawn : PackedScene = preload("res://Scenes/enemy.tscn")
var lives 
var money 
var wave 
@onready var markers = $Markers
@onready var target_1 = $Markers/Target1


func _ready():
	set_stats()
	
	if wave == 1:
		for i in range (0, 10):
			await get_tree().create_timer(0.5).timeout
			spawn_loop(enemy_to_spawn)
		wave += 1
		print(wave)
	if wave == 2:
		for i in range (0 ,20):
			await get_tree().create_timer(0.66).timeout
			for j in range (0, 3):
				await get_tree().create_timer(0.2).timeout
				spawn_loop(enemy_to_spawn)
	
		
func _unhandled_input(event):
	if Input.is_action_just_pressed("place"):
		var tower = selected_tower.instantiate()
		add_child(tower)
		tower.global_position = event.global_position

func _on_path_area_body_entered(body):
	if body.is_in_group("Tower"):
		body.queue_free()

func spawn_loop(packed_enemy):
	var enemy = packed_enemy.instantiate()
	add_child(enemy)
	enemy.global_position = Vector2(0, 352)
	var target_marker = 0
	for marker in markers.get_child_count():
		var target_position = markers.get_child(target_marker).global_position
		var tween = get_tree().create_tween()
		var distance = enemy.position.distance_to(target_position)
		tween.tween_property(enemy, "global_position", target_position, distance / enemy.SPEED)
		await tween.finished
		target_marker += 1
	if enemy.global_position == markers.get_child(2).global_position and enemy.visible:
		print("END")
		GlobalStats.stats_change(GlobalStats.stats["lives"], enemy.DAMAGE)
		print(lives)
		enemy.queue_free()
func change_stats():
	GlobalStats.stats_changed.connect(set_stats)
	set_stats()
	
func set_stats():
	lives = GlobalStats.stats["lives"]
	money = GlobalStats.stats["money"]
	wave = GlobalStats.stats["wave"]
	print(GlobalStats.stats["money"])
