class_name BundleRoot
extends BundleNode

@export var title: String = ""
@export var author: String = ""
@export var description: String = ""
@export var version: String = ""
@export var unique_name: String = "bearware.built-in.empty_bundle"



func from_dict(dict: Dictionary) -> void:
	title = dict.get("title", "")
	author = dict.get("author", "")
	description = dict.get("description", "")
	version = dict.get("version", "")
	unique_name = dict.get("unique_name", "bearware.built-in.empty_bundle")
	return


func to_dict() -> Dictionary:
	return {
		"title": title,
		"author": author,
		"description": description,
		"version": version,
		"unique_name": unique_name
	}
