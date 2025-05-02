class_name BundleElementNode
extends BundleNode

var display_name: String = ""
var unique_name: String = ""



static func element_from_type_str(element_type: String) -> BundleElementNode:
	match element_type:
		"numeric": return BundleElementNumeric.new()
		"text": return BundleElementText.new()
		"sheet_reference": return BundleElementSheetRef.new()
		"set": return BundleElementSet.new()
		_: return BundleElementNode.new()

func from_dict(dict: Dictionary) -> void:
	display_name = dict.get("display_name", "")
	unique_name = dict.get("unique_name", "")


func to_dict() -> Dictionary:
	return {
		"element": "empty",
		"display_name": display_name,
		"unique_name": unique_name
	}
