extends Control

@onready var bundle_selector: OptionButton = $List/BundleSelector
@onready var bundle_title: Label = $List/BundleTitle
@onready var bundle_author: Label = $List/BundleAuthor
@onready var bundle_description: Label = $List/BundleDescription



func _ready() -> void:
	BundleManager.load_bundles()
	for bundle in BundleManager.get_bundles():
		bundle_selector.add_item(bundle.unique_name)
	bundle_selector.select(0)
	_change_to_bundle(0)


func _change_to_bundle(index: int) -> void:
	var bundle_count: int = BundleManager.get_bundles().size()
	var bundle: BundleRoot = BundleManager.get_bundles()[index % bundle_count]
	bundle_title.text = bundle.title
	bundle_author.text = bundle.author
	bundle_description.text = bundle.description
