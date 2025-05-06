class_name BundleElementNumeric
extends BundleElementNode

var max: float = 10
var min: float = 1
var increment: float = 1
var default: float = 1



func from_dict(dict: Dictionary) -> ERR:
	placeholder_text = dict.get("placeholder_text", "")
	display_name = dict.get("display_name", "")
	unique_name = dict.get("unique_name", "")
	max = dict.get("max", 10)
	min = dict.get("min", 1)
	increment = dict.get("increment", 1)
	default = dict.get("default", 1)
	return ERR.OK


func to_dict() -> Dictionary:
	return {
		"element": "numeric",
		"placeholder_text": placeholder_text,
		"display_name": display_name,
		"unique_name": unique_name,
		"max": max,
		"min": min,
		"increment": increment,
		"default": default,
	}
