class_name BundleElementSheetRef
extends BundleElementNode

signal reference_changed(value: BundleNode)

var _sheet_ref: String


func get_reference() -> String:
	return _sheet_ref


func set_reference(reference: String) -> ERR:
	var node: BundleNode = BundleManager.get_bundle_node(reference)
	if not node:
		return ERR.CANNOT_FIND_UNIQUE_NAME
	if not is_node_referencable(node):
		return ERR.INVALID_REFERENCE
	_sheet_ref = reference
	reference_changed.emit(get_referenced_node())
	return ERR.OK


func get_referenced_node() -> BundleNode:
	var node: BundleNode = BundleManager.get_bundle_node(_sheet_ref)
	if not is_node_referencable(node):
		return null
	return node


func set_referenced_node(node: BundleNode) -> ERR:
	if not is_node_referencable(node):
		return ERR.INVALID_REFERENCE
	var reference: String = BundleManager.get_unique_name(node)
	if not reference:
		return ERR.CANNOT_FIND_UNIQUE_NAME
	return set_reference(reference)


func is_node_referencable(node: BundleNode) -> bool:
	if not (
			node is BundleElementNumeric or
			node is BundleElementSet or 
			node is BundleSheet or
			node is BundleElementText
	):
		return false
	# Pre-setup for more data/ref validation as needed.
	return true


func from_dict(dict: Dictionary) -> ERR:
	placeholder_text = dict.get("placeholder_text", "")
	display_name = dict.get("display_name", "")
	unique_name = dict.get("unique_name", "")
	_sheet_ref = dict.get("sheet_un", "")
	return ERR.OK


func to_dict() -> Dictionary:
	return {
		"element": "sheet_reference",
		"placeholder_text": placeholder_text,
		"display_name": display_name,
		"unique_name": unique_name,
		"sheet_un": _sheet_ref,
	}
