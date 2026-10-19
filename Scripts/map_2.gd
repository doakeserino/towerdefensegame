extends Node2D
var selected_tower : PackedScene = preload("res://Scenes/tower.tscn")
var enemy_to_spawn : PackedScene = preload("res://Scenes/enemy.tscn")
var lives : int = 100
@onready var target_1 = $Target1
@onready var markers = $Markers


func _ready():
	for i in range (1, 10):
		await get_tree().create_timer(1.0).timeout
		spawn_loop(enemy_to_spawn)
		
func _input(event):
	if Input.is_action_just_pressed("place"):
		var tower = selected_tower.instantiate()
		add_child(tower)
		tower.position = event.position / 2

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
		print("Arrived", target_marker)
		target_marker += 1
	if enemy.global_position == markers.get_child(2).global_position:
		print("END")
		lives -= enemy.DAMAGE
		print(lives)
		enemy.queue_free()
