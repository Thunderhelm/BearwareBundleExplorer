class_name BundleElementText
extends BundleElementNode

signal default_changed(value: String)

var default: String = "":
	set(val):
		default = val
		default_changed.emit(val)


func from_dict(dict: Dictionary) -> ERR:
	placeholder_text = dict.get("placeholder_text", "")
	display_name = dict.get("display_name", "")
	unique_name = dict.get("unique_name", "")
	default = dict.get("default", "")
	return ERR.OK


func to_dict() -> Dictionary:
	return {
		"element": "text",
		"placeholder_text": placeholder_text,
		"display_name": display_name,
		"unique_name": unique_name,
		"default": default,
	}
