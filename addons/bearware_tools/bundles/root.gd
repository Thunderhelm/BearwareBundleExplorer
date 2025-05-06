class_name BundleRoot
extends BundleNode


@export var title: String = ""
@export var author: String = ""
@export var description: String = ""
@export var version: String = ""
@export var file_path: String


func _ready() -> void:
	if file_path:
		_load_bundle()


func get_sheets() -> Array[BundleSheet]:
	var sheets: Array[BundleSheet] = []
	for child in get_children():
		if child is BundleSheet:
			sheets.append(child)
	return sheets


func get_tokens() -> void:
	return


func get_runes() -> void:
	return


func _load_bundle() -> void:
	if not FileAccess.file_exists(file_path):
		log_error("Could not finish loading bundle: File does not exist")
	var file := FileAccess.open(file_path, FileAccess.READ)
	var content: String = file.get_as_text()
	file.close()
	var data: Dictionary = JSON.parse_string(content)
	if data.get("sheets", []) is Array:
		var sheets: Array = data.get("sheets", [])
		_load_sheets(sheets)
	return


func _load_sheets(sheets: Array) -> void:
	for sheet in sheets:
		if sheet is not Dictionary:
			log_warning("Unknown data found in sheet list, skipping")
			continue
		var sheet_node: BundleSheet = BundleSheet.new()
		sheet_node.from_dict(sheet)
		var status: BundleManager.ERR = BundleManager.register_node(sheet_node)
		if status != BundleManager.ERR.OK:
			sheet_node.queue_free()
			continue
		else:
			sheet_node.name = sheet_node.unique_name
			add_child(sheet_node)
			sheet_node.register_uns(unique_name)
	return


func _load_tokens(tokens: Array[Dictionary]) -> void:
	return


func _load_runes(runes: Array[Dictionary]) -> void:
	return


func from_dict(dict: Dictionary) -> ERR:
	title = dict.get("title", "")
	author = dict.get("author", "")
	description = dict.get("description", "")
	version = dict.get("version", "")
	unique_name = dict.get("unique_name", "bearware.built-in.empty_bundle")
	return ERR.OK


func to_dict() -> Dictionary:
	return {
		"title": title,
		"author": author,
		"description": description,
		"version": version,
		"unique_name": unique_name
	}
