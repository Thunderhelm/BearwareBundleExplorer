class_name BundleSheet
extends BundleNode

@export var display_name: String = ""
@export var unique_name: String = ""



func get_elements() -> Array[BundleElementNode]:
	var elements: Array[BundleElementNode] = []
	for child in get_children():
		if child is BundleElementNode:
			elements.append(child)
	return elements


func to_dict() -> Dictionary:
	return {
		"display_name": display_name,
		"unique_name": unique_name,
		"elements": elements_to_dict()
	}


func from_dict(dict: Dictionary) -> void:
	display_name = dict.get("display_name", "")
	unique_name = dict.get("unique_name", "")
	dict.get("elements", []).map(_add_elem_from_dict)


func _register_element(prefix: String, node: Node):
	if node is BundleElementNode:
		var elem: BundleElementNode = node
		prefix = prefix + "->" + elem.unique_name
		BundleManager.bundle_map[prefix] = elem
	for child in node.get_children():
		_register_element(prefix, child)


func register_uns(root_un: String):
	var full_un: String = root_un + "->sheets->" + unique_name
	BundleManager.bundle_map[full_un] = self
	for child in get_children():
		_register_element(full_un, child)


func elements_to_dict() -> Array[Dictionary]:
	var element_dicts: Array[Dictionary] = []
	for element in get_elements():
		element_dicts.append(element.to_dict())
	return element_dicts


func _add_elem_from_dict(dict: Dictionary) -> void:
	var node: BundleElementNode = BundleElementNode.element_from_type_str(dict.get("element", "empty"))
	node.from_dict(dict)
	if node.unique_name == "":
		node.queue_free()
	else:
		node.name = node.unique_name
		add_child(node)
