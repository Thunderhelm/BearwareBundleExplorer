class_name BundleNode
extends Node

enum ERR {
	OK,
	INVALID_JSON,
	INVALID_JSON_FORMAT,
	FILE_DOESNT_EXIST,
	INVALID_REFERENCE,
	CANNOT_FIND_UNIQUE_NAME,
	ABSTRACT_IMPLEMENTATION,
	INCOMPATIBLE_ELEMENT,
}

# Goal is to be unique to every node as a reference that can be used by
# the bundle manager. In general, the root of all unique names identifies
# the bundle itself and is typically made of 5 parts, though this cannot
# be assumed. The parts are as follows:
# author->setting(series/world)->style(core/addendum/brew)->system-name->edition
var unique_name: String = ""
var display_name: String = ""


func log_info(message: String) -> void:
	_log("[ - ]", message, "white")


func log_alert(message: String) -> void:
	_log("[(i)]", message, "green")


func log_warning(message: String) -> void:
	_log("[/!\\]", message, "yellow")


func log_error(message: String) -> void:
	_log("[!X!]", message, "red")


func _log(symbol: String, message: String, color: String) -> void:
	var to_print: String = "[color={clr}]{sym}\\[{un}\\]: {msg}[/color]"
	to_print = to_print.format({
		"clr": color,
		"sym": symbol,
		"un": unique_name,
		"msg": message,
	})
	print_rich(to_print)


func to_str() -> String:
	var data: Dictionary = to_dict()
	return JSON.stringify(data)


func from_str(str: String) -> ERR:
	var json: JSON = JSON.new()
	var err: int = json.parse(str)
	if err != OK:
		return ERR.INVALID_JSON
	
	if json.data is Dictionary:
		from_dict(json.data)
		return ERR.OK
	else:
		return ERR.INVALID_JSON_FORMAT


func to_file(path: String) -> ERR:
	# takes a path and removes the file part (/dir1/dir2/file.txt to /dir1/dir2)
	var directory: String = "/".join(path.split("/").slice(0, -1))
	if DirAccess.dir_exists_absolute(directory):
		var data: String = to_str()
		var file: FileAccess = FileAccess.open(path, FileAccess.WRITE)
		file.store_string(data)
		file.close()
		return ERR.OK
	else:
		return ERR.FILE_DOESNT_EXIST


func from_file(path: String) -> ERR:
	if not FileAccess.file_exists(path):
		log_error("Could not load file: {}, does not exist".format(path))
		return ERR.FILE_DOESNT_EXIST
	
	var file := FileAccess.open(path, FileAccess.READ)
	var file_content: String = file.get_as_text()
	file.close()
	var status: ERR = from_str(file_content)
	match status:
		ERR.INVALID_JSON:
			log_error("Could not load file: {}, invalid JSON".format(path))
		ERR.INVALID_JSON_FORMAT:
			log_error("Could not load file: {}, JSON in wrong format".format(path))
	return status


func to_dict() -> Dictionary:
	return {}


func from_dict(dict: Dictionary) -> ERR:
	return ERR.OK
