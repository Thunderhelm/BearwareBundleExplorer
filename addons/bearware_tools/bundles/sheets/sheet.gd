class_name BundleSheet
extends BundleNode


func get_elements() -> Array[BundleElementNode]:
	var elements: Array[BundleElementNode] = []
	for child in get_children():
		if child is BundleElementNode:
			elements.append(child)
	return elements


func register_uns(root_un: String):
	var full_un: String = root_un + "->sheets->" + unique_name
	for child in get_children():
		_register_element(full_un, child)


func _register_element(prefix: String, node: Node):
	if node is BundleElementNode:
		prefix = prefix + "->" + node.unique_name
		BundleManager.register_unique_name(prefix, node)
	for child in node.get_children():
		_register_element(prefix, child)


func _add_element_from_dict(dict: Dictionary) -> void:
	var type_string: String = dict.get("element", "empty")
	var node: BundleElementNode = BundleElementNode.element_from_type_str(type_string)
	node.from_dict(dict)
	if node.unique_name == "":
		node.queue_free()
	else:
		node.name = node.unique_name
		add_child(node)


func to_dict() -> Dictionary:
	return {
		"display_name": display_name,
		"unique_name": unique_name,
		"elements": elements_to_dict()
	}


func elements_to_dict() -> Array[Dictionary]:
	var element_dicts: Array[Dictionary] = []
	for element in get_elements():
		element_dicts.append(element.to_dict())
	return element_dicts


func from_dict(dict: Dictionary) -> ERR:
	display_name = dict.get("display_name", "")
	unique_name = dict.get("unique_name", "")
	dict.get("elements", []).map(_add_element_from_dict)
	return ERR.OK
