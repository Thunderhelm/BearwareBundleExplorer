class_name BundleRune
extends BundleNode

var catalyst: BundleRuneCatalyst:
	set(val):
		if catalyst:
			catalyst.catalyst_activated.disconnect(_catalyst_activated)
		catalyst = val
		catalyst.catalyst_activated.connect(_catalyst_activated)

var binding: BundleRuneBinding



func _catalyst_activated(data: Array) -> void:
	return
