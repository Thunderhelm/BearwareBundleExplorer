class_name BundleNode
extends Node



#
# Overwrite in children
#
func from_dict(dict: Dictionary) -> void:
	return


func to_dict() -> Dictionary:
	return {}



#
# do not overwrite in children
#
func from_str(str: String) -> void:
	var json: JSON = JSON.new()
	var err: int = json.parse(str)
	if err != OK:
		print("error parsing json!")
		return
	
	if typeof(json.data) == TYPE_DICTIONARY:
		from_dict(json.data)
		return
	else:
		print("json is not dict")
		return


func to_str() -> String:
	return JSON.stringify(to_dict())


func from_file(path: String) -> void:
	var file: FileAccess
	if FileAccess.file_exists(path):
		file = FileAccess.open(path, FileAccess.READ)
	else:
		return
	
	var content: String = file.get_as_text()
	file.close()
	from_str(content)
	return


func to_file(path: String) -> void:
	var file_name_length: int = path.split("/")[-1].length()
	var dir_name: String = path.left(file_name_length * -1)
	if DirAccess.dir_exists_absolute(dir_name):
		var file: FileAccess = FileAccess.open(path, FileAccess.WRITE)
		file.store_string(to_str())
		file.close()
	return
