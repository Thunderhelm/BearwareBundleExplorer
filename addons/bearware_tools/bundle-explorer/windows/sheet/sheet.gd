extends Button


@onready var element_list: VBoxContainer = $Window/Border/Elements

var sheet: BundleSheet:
	set(val):
		sheet = val
		text = "      " + sheet.display_name
		$Window/Border/Elements/Name/Value.text = sheet.display_name
		$Window/Border/Elements/UN.text = sheet.unique_name
		sheet.get_elements().map(_add_element)



func _add_element(elem: BundleElementNode) -> void:
	if elem is BundleElementNumeric:
		var numeric_display: PanelContainer = preload("uid://c1q3afxsxa73h").instantiate()
		element_list.add_child(numeric_display)
		numeric_display.source_numeric = elem
	return
