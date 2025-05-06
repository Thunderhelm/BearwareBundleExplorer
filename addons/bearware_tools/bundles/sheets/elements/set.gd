class_name BundleElementSet
extends BundleElementNode

var max_selectable: int = 1
var min_selectable: int = 0
var default_selected: int = 0
var lock_elements: bool = false


func get_elements() -> Array[BundleElementNode]:
	var elements: Array[BundleElementNode] = []
	for child in get_children():
		if child is BundleElementNode:
			elements.append(child)
	return elements


func from_dict(dict: Dictionary) -> ERR:
	placeholder_text = dict.get("placeholder_text", "")
	display_name = dict.get("display_name", "")
	unique_name = dict.get("unique_name", "")
	max_selectable = dict.get("max_selectable", 1)
	min_selectable = dict.get("min_selectable", 0)
	default_selected = dict.get("default_selected", 0)
	lock_elements = dict.get("lock_elements", false)
	dict.get("set_elements", []).map(_add_elem_from_dict)
	return ERR.OK


func to_dict() -> Dictionary:
	return {
		"element": "set",
		"placeholder_text": placeholder_text,
		"display_name": display_name,
		"unique_name": unique_name,
		"max_selectable": max_selectable,
		"min_selectable": min_selectable,
		"default_selected": default_selected,
		"lock_elements": lock_elements,
		"set_elements": get_elements().map(_get_as_dict),
	}


func _get_as_dict(element: BundleElementNode) -> Dictionary:
	return element.to_dict()


func _add_elem_from_dict(dict: Dictionary) -> void:
	var node: BundleElementNode = element_from_type_str(dict.get("element", "empty"))
	node.from_dict(dict)
	if node.unique_name == "":
		node.queue_free()
	else:
		node.name = node.unique_name
		add_child(node)
