extends RigidBody2D

var bullet : PackedScene = preload("res://Scenes/bullet.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func shoot(target):
	var new_bullet = bullet.instantiate()
	add_child(new_bullet)
	# Create tween for bullet position to target position
	var tween = get_tree().create_tween()
	tween.tween_property(new_bullet, "position", target.global_position, 1.0)
