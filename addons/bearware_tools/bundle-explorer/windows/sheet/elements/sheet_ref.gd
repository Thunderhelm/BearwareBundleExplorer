extends Control

@onready var ref_un: Label = $Details/RefUN

var source_ref: BundleElementSheetRef:
	set(val):
		source_ref = val
		$Details/DisplayName.text = source_ref.display_name
		$Details/UniqueName.text = source_ref.unique_name
		ref_un.text = source_ref._sheet_ref
		var display: Control
		if val.sheet_node is BundleElementNumeric:
			display = preload("uid://c1q3afxsxa73h").instantiate()
			display.source_numeric = val.sheet_node
		if val.sheet_node is BundleElementText:
			display = preload("uid://dr5yrh8gsnirt").instantiate()
			display.source_text = val.sheet_node
		if val.sheet_node is BundleSheet:
			display = Label.new()
			display.text = "Links to " + val.sheet_node.display_name
		if not display:
			return
		display.name = "Display"
		$Details.remove_child($Details.get_node("Display"))
		$Details.add_child(display)
