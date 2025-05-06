extends Node

signal unique_name_registered(unique_name: String, node: BundleNode)
signal unique_name_deregistered(unique_name: String, node: BundleNode)
signal bundle_loaded(unique_name: String, root: BundleRoot, path: String)
signal bundles_reloaded()

enum ERR {
	OK,
	DIRECTORY_DOESNT_EXIST,
	INVALID_FILE_TYPE,
	UNIQUE_NAME_NOT_REGISTERED,
	NODE_NOT_REGISTERED,
	UNIQUE_NAME_ALREADY_REGISTERED,
	NODE_ALREADY_REGISTERED,
}

const FILE_EXTENSIONS: Array[String] = [
	".bbndl",
	".json",
]

var bundle_paths: Array[String] = [
	"res://addons/bearware_tools/bundles/built-ins/",
	"user://bundles/"
]
var _bundle_map: Dictionary[String, BundleNode] = {}


func _ready() -> void:
	reload_bundles()


func reload_bundles() -> ERR:
	for path in bundle_paths:
		load_bundles_from_directory(path)
	bundles_reloaded.emit()
	return ERR.OK


func load_bundles_from_directory(directory: String) -> ERR:
	var dir_access: DirAccess = DirAccess.open(directory)
	if not dir_access:
		return ERR.DIRECTORY_DOESNT_EXIST
	if not directory.ends_with("/"):
		directory = directory + "/"
	for file in dir_access.get_files():
		load_bundle_from_file(directory + file)
	return ERR.OK


func load_bundle_from_file(path: String) -> ERR:
	var file_extension: String = path.split(".", false, 1)[-1]
	if file_extension not in FILE_EXTENSIONS:
		return ERR.INVALID_FILE_TYPE
	var bundle_root: BundleRoot = BundleRoot.new()
	bundle_root.from_file(path)
	var status: ERR = register_unique_name(bundle_root.unique_name, bundle_root)
	if status != ERR.OK:
		bundle_root.queue_free()
		return ERR.UNIQUE_NAME_ALREADY_REGISTERED
	else:
		bundle_root.file_path = path
		bundle_root.name = bundle_root.unique_name
		add_child(bundle_root)
		bundle_loaded.emit(bundle_root.unique_name, bundle_root, path)
		return ERR.OK


func get_bundles() -> Array[BundleRoot]:
	var result: Array[BundleRoot] = []
	for child in get_children():
		if child is BundleRoot:
			result.append(child)
	return result


func register_unique_name(unique_name: String, node: BundleNode) -> ERR:
	if unique_name in _bundle_map.keys() or unique_name == "":
		return ERR.UNIQUE_NAME_ALREADY_REGISTERED
	if _bundle_map.find_key(node):
		return ERR.NODE_ALREADY_REGISTERED
	_bundle_map[unique_name] = node
	unique_name_registered.emit(unique_name, node)
	return ERR.OK


func register_node(node: BundleNode) -> ERR:
	return register_unique_name(node.unique_name, node)


func deregister_unique_name(unique_name: String) -> ERR:
	if unique_name not in _bundle_map.keys():
		return ERR.UNIQUE_NAME_NOT_REGISTERED
	var node: BundleNode = _bundle_map[unique_name]
	_bundle_map.erase(unique_name)
	unique_name_deregistered.emit(unique_name, node)
	return ERR.OK


func deregister_node(node: BundleNode) -> ERR:
	var unique_name: String = get_unique_name(node)
	if not unique_name:
		return ERR.NODE_NOT_REGISTERED
	deregister_unique_name(unique_name)
	return ERR.OK


func get_unique_name(node: BundleNode) -> String:
	return _bundle_map.find_key(node)


func get_bundle_node(unique_name: String) -> BundleNode:
	return _bundle_map.get(unique_name, null)
