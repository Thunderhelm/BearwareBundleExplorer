extends Control

@onready var max_selectable_box: SpinBox = $Details/MaxSelectable/Value
@onready var min_selectable_box: SpinBox = $Details/MinSelectable/Value
@onready var default_box: SpinBox = $Details/DefaultSelectable/Value
@onready var locked_button: CheckButton = $Details/Locked/Value
@onready var elements_list: VBoxContainer = $Details/Elements

var source_set: BundleElementSet:
	set(val):
		source_set = val
		$Details/DisplayName.text = source_set.display_name
		$Details/UniqueName.text = source_set.unique_name
		max_selectable_box.value = source_set.max_selectable
		min_selectable_box.value = source_set.min_selectable
		default_box.value = source_set.default_selected
		locked_button.button_pressed = source_set.lock_elements
		for child in elements_list.get_children():
			elements_list.remove_child(child)
		for elem in source_set.get_elements():
			var display: Control
			if elem is BundleElementNumeric:
				display = preload("uid://c1q3afxsxa73h").instantiate()
				elements_list.add_child(display)
				display.source_numeric = elem
			if elem is BundleElementText:
				display = preload("uid://dr5yrh8gsnirt").instantiate()
				elements_list.add_child(display)
				display.source_text = elem
			if elem is BundleElementSheetRef:
				display = preload("uid://dpratar3w17ic").instantiate()
				elements_list.add_child(display)
				display.source_ref = elem
			if elem is BundleElementSet:
				display = preload("uid://biyy31agk8vxb").instantiate()
				elements_list.add_child(display)
				display.source_set = elem
