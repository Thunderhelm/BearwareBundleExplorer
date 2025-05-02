class_name BundleElementText
extends BundleElementNode

var default: String = ""



func from_dict(dict: Dictionary) -> void:
	display_name = dict.get("display_name", "")
	unique_name = dict.get("unique_name", "")
	default = dict.get("default", "")


func to_dict() -> Dictionary:
	return {
		"element": "text",
		"display_name": display_name,
		"unique_name": unique_name,
		"default": default
	}
