class_name BundleElementNode
extends BundleNode

signal element_changed()
signal placeholder_text_changed(value: String)

@export var placeholder_text: String = "":
	set(val):
		placeholder_text = val
		placeholder_text_changed.emit(val)
		element_changed.emit()


static func element_from_type_str(element_type: String) -> BundleElementNode:
	match element_type:
		"numeric": 
			return BundleElementNumeric.new()
		"text": 
			return BundleElementText.new()
		"sheet_reference": 
			return BundleElementSheetRef.new()
		"set": 
			return BundleElementSet.new()
		_: 
			return BundleElementNode.new()


func from_dict(dict: Dictionary) -> ERR:
	display_name = dict.get("display_name", "")
	unique_name = dict.get("unique_name", "")
	placeholder_text = dict.get("placeholder_text", "")
	return ERR.OK


func to_dict() -> Dictionary:
	return {
		"element": "empty",
		"display_name": display_name,
		"unique_name": unique_name,
		"placeholder_text": placeholder_text,
	}
