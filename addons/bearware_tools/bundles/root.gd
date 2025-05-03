class_name BundleRoot
extends BundleNode

@export var title: String = ""
@export var author: String = ""
@export var description: String = ""
@export var version: String = ""
#author->setting(series or world)->style(core, addendum, brew)->system-name->edition
@export var unique_name: String = "bearware->built-in->core->empty_bundle->0e"



func get_sheets() -> Array[BundleSheet]:
	var sheets: Array[BundleSheet] = []
	for child in get_children():
		if child is BundleSheet:
			sheets.append(child)
	return sheets


func _ready() -> void:
	if self not in BundleManager.bundle_files:
		return
	_load_bundle(BundleManager.bundle_files[self])


func _load_bundle(path: String) -> void:
	var file: FileAccess = FileAccess.open(path, FileAccess.READ)
	var content: String = file.get_as_text()
	file.close()
	var data: Dictionary = JSON.parse_string(content)
	if typeof(data.get("sheets", [])) == TYPE_ARRAY:
		var sheets: Array = data.get("sheets", [])
		_load_sheets(sheets)
	return


func _load_sheets(sheets: Array) -> void:
	for sheet in sheets:
		if typeof(sheet) != TYPE_DICTIONARY:
			continue
		var sheet_node: BundleSheet = BundleSheet.new()
		sheet_node.from_dict(sheet)
		if sheet_node.unique_name == "":
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
