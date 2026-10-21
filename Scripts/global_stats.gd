extends Node

signal stats_changed
var stats = {
	"lives" : 100,
	"money" : 100,
	"wave" : 1
}
func _ready():
	stats["wave"] = 1
	
func stats_change(stat_changed, amount : int):
	stat_changed += amount
	stats_changed.emit()
	print(stat_changed, amount)
