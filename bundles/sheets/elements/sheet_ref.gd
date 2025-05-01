class_name BundleElementSheetRef
extends BundleElementNode

var sheet: BundleSheet



#func from_dict(dict: Dictionary) -> void:
	#sheet = dict.get("default", "")


#func to_dict() -> Dictionary:
#	return {
#		"default": default
#	}
