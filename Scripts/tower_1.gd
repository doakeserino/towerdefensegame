class_name tower_1
extends root_tower


func _ready():
	tower_range = 150
	print(self is root_tower)
	print(tower_range)
	collision_shape_2d.shape.radius = tower_range
	

func _process(_delta):
	super(_delta)
