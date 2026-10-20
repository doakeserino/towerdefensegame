class_name root_tower
extends RigidBody2D

@onready var gun = $Gun
@onready var collision_shape_2d = $Area2D/CollisionShape2D

var has_enemies : bool
var enemies = []
var target
var shooting : bool = false
var tower_range := 100
var firing_cooldown : float = 0.2
func _ready():
	pass

func _process(_delta):
	collision_shape_2d.shape.radius = tower_range
	if enemies.size() > 0:
		has_enemies = true
		target = enemies[0]
	else:
		has_enemies = false
	if has_enemies and not shooting:
		shoot()
		var cooldown = get_tree().create_timer(firing_cooldown)
		await cooldown.timeout
		shooting = false

func _on_area_2d_body_entered(body):
	if body.is_in_group("Damages"):
		enemies.append(body)
		print(enemies)

func _on_area_2d_body_exited(body):
	if body.is_in_group("Damages"):
		enemies.erase(body)

func shoot():
	gun.shoot(target)
