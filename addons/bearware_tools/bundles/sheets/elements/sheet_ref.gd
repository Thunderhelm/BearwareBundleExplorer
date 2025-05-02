class_name BundleElementSheetRef
extends BundleElementNode

var _sheet_ref: String
var sheet: BundleNode:
	get:
		var node: BundleNode = BundleManager.bundle_map[_sheet_ref]
		if node:
			return BundleManager.bundle_map[_sheet_ref]
		return
	set(val):
		var ref: String = BundleManager.bundle_map.find_key(val)
		if ref.split("->").size() < 5:
			_sheet_ref = ""
			return
		if ref and ref.split("->")[5] == "sheets":
			_sheet_ref = ref
		else:
			_sheet_ref = ""



func from_dict(dict: Dictionary) -> void:
	display_name = dict.get("display_name", "")
	unique_name = dict.get("unique_name", "")
	_sheet_ref = dict.get("sheet_un", "")


func to_dict() -> Dictionary:
	return {
		"element": "sheet_reference",
		"display_name": display_name,
		"unique_name": unique_name,
		"sheet_un": _sheet_ref
	}
