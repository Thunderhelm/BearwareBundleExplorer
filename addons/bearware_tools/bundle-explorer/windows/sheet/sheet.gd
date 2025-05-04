extends Button


@onready var element_list: VBoxContainer = $Window/Scroll/Border/Elements

var sheet: BundleSheet:
	set(val):
		sheet = val
		text = "      " + sheet.display_name
		$Window/Scroll/Border/Elements/Name/Value.text = sheet.display_name
		$Window/Scroll/Border/Elements/UN.text = sheet.unique_name
		sheet.get_elements().map(_add_element)



func _add_element(elem: BundleElementNode) -> void:
	if elem is BundleElementNumeric:
		var numeric_display: Control = preload("uid://c1q3afxsxa73h").instantiate()
		element_list.add_child(numeric_display)
		numeric_display.source_numeric = elem
	if elem is BundleElementText:
		var text_display: Control = preload("uid://dr5yrh8gsnirt").instantiate()
		element_list.add_child(text_display)
		text_display.source_text = elem
	if elem is BundleElementSheetRef:
		var ref_display: Control = preload("uid://dpratar3w17ic").instantiate()
		element_list.add_child(ref_display)
		ref_display.source_ref = elem
	if elem is BundleElementSet:
		var set_display: Control = preload("uid://biyy31agk8vxb").instantiate()
		element_list.add_child(set_display)
		set_display.source_set = elem
	return
