extends RigidBody2D

@onready var gun = $Gun

var has_enemies : bool
var enemies = []
var target
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if enemies.size() > 0:
		has_enemies = true
		target = enemies[0]
	else:
		has_enemies = false
	while has_enemies:
		shoot()
		var cooldown = get_tree().create_timer(1.0)
		await cooldown.timeout
func _on_area_2d_body_entered(body):
	if body.is_in_group("Damages"):
		enemies.append(body)
		print(enemies)

func _on_area_2d_body_exited(body):
	if body.is_in_group("Damages"):
		enemies.erase(body)

func shoot():
	gun.shoot(target)
