class_name BundleElementNumeric
extends BundleElementNode

var max: float = 10
var min: float = 1
var increment: float = 1
var default: float = 1



func from_dict(dict: Dictionary) -> void:
	max = dict.get("max", 10)
	min = dict.get("min", 1)
	increment = dict.get("increment", 1)
	default = dict.get("default", 1)


func to_dict() -> Dictionary:
	return {
		"max": max,
		"min": min,
		"increment": increment,
		"default": default
	}
