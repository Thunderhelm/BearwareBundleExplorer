extends Node

const FILE_EXT: String = ".bbndl"
const OPT_FILE_EXT: String = ".json"


var bundle_paths: Array[String] = [
	"res://addons/bearware_tools/bundles/built-ins/",
	"user://bundles/"
]
var bundle_map: Dictionary[String, BundleNode] = {}
var bundle_files: Dictionary[BundleRoot, String] = {}



func get_bundles() -> Array[BundleRoot]:
	var result: Array[BundleRoot] = []
	for child in get_children():
		if child is BundleRoot:
			result.append(child)
	return result


func load_bundles() -> void:
	for path in bundle_paths:
		load_bundles_from_path(path)


func load_bundles_from_path(path: String) -> void:
	if not path.ends_with("/"):
		path = path + "/"
	var dir: DirAccess = DirAccess.open(path)
	if dir == null:
		return
	for file in dir.get_files():
		load_bundle_from_file(path + file)
	return


func load_bundle_from_file(path: String) -> void:
	if not (path.ends_with(FILE_EXT) or path.ends_with(OPT_FILE_EXT)):
		return
	var bundle_root: BundleRoot = BundleRoot.new()
	bundle_root.from_file(path)
	if bundle_root.unique_name in bundle_map.keys():
		bundle_root.queue_free()
	else:
		bundle_files[bundle_root] = path
		bundle_root.name = bundle_root.unique_name
		add_child(bundle_root)
