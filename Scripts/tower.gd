extends RigidBody2D

@onready var gun = $Gun

var has_enemies : bool
var enemies = []
var target
var shooting : bool = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if enemies.size() > 0:
		has_enemies = true
		target = enemies[0]
	else:
		has_enemies = false
	if has_enemies and not shooting:
		shoot()
		var cooldown = get_tree().create_timer(1.0)
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
