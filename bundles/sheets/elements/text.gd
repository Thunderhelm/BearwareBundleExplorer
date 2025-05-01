class_name BundleElementText
extends BundleElementNode

var default: String = ""



func from_dict(dict: Dictionary) -> void:
	default = dict.get("default", "")


func to_dict() -> Dictionary:
	return {
		"default": default
	}
