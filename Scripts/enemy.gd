class_name enemy_class
extends RigidBody2D

var is_alive : bool = true
var money_drop := 1
@onready var hitbox = $Hitbox
@onready var collision_shape_2d = $CollisionShape2D
@onready var sprite_2d = $Sprite2D


const SPEED = 300.0
const DAMAGE = 10

var health := 1
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if health < 1 and is_alive:
		die()

func take_damage(damage : int):
	health -= damage


func _on_hitbox_body_entered(body):
	if body.is_in_group("bullet"):
		take_damage(body.damage)

func die():
	is_alive = false
	GlobalStats.stats_change(GlobalStats.stats["money"], money_drop)
	visible = false
	hitbox.monitoring = false
	collision_shape_2d.disabled = true
