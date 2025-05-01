extends Node

const FILE_EXT: String = ".bbndl"


var bundle_paths: Array[String] = [
	"res://built-ins/",
	"user://bundles/"
]
var unique_name_map: Dictionary[String, BundleNode] = {}



func _ready() -> void:
	for path in bundle_paths:
		load_bundles_from_path(path)


func load_bundles_from_path(path: String) -> void:
	
	return


func load_bundle_from_file(path: String) -> void:
	return
