extends Control

@onready var default_box: TextEdit = $Details/TextEdit

var source_text: BundleElementText:
	set(val):
		source_text = val
		$Details/DisplayName.text = source_text.display_name
		$Details/UniqueName.text = source_text.unique_name
		default_box.text = source_text.default
