extends Node

const FILE_EXT: String = ".bbndl"
const OPT_FILE_EXT: String = ".json"


var bundle_paths: Array[String] = [
	"res://built-ins/",
	"user://bundles/"
]
var unique_name_map: Dictionary[String, BundleNode] = {}



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
	if bundle_root.unique_name in unique_name_map.keys():
		bundle_root.queue_free()
	else:
		add_child(bundle_root)
		unique_name_map[bundle_root.unique_name] = bundle_root
