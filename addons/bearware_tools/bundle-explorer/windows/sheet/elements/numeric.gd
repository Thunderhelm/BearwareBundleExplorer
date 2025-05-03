extends Control

@onready var max_box: SpinBox = $Details/Max/Value
@onready var min_box: SpinBox = $Details/Min/Value
@onready var increment_box: SpinBox = $Details/Increment/Value
@onready var default_box: SpinBox = $Details/Default/Value

var source_numeric: BundleElementNumeric:
	set(val):
		source_numeric = val
		$Details/DisplayName.text = source_numeric.display_name
		$Details/UniqueName.text = source_numeric.unique_name
		max_box.value = source_numeric.max
		min_box.value = source_numeric.min
		increment_box.value = source_numeric.increment
		default_box.value = source_numeric.default
