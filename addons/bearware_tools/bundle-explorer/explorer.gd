extends Window

@onready var bundle_selector: OptionButton = $Scroll/List/BundleSelector
@onready var bundle_title: Label = $Scroll/List/BundleTitle
@onready var bundle_author: Label = $Scroll/List/BundleAuthor
@onready var bundle_description: Label = $Scroll/List/BundleDescription

@onready var all_uns_button: Button = $Scroll/List/Details/AllUNs
@onready var all_uns_window: Window = $Scroll/List/Details/AllUNs/Window
@onready var all_uns_list: VBoxContainer = $Scroll/List/Details/AllUNs/Window/Scroll/List



func _ready() -> void:
	BundleManager.load_bundles()
	for bundle in BundleManager.get_bundles():
		bundle_selector.add_item(bundle.unique_name)
	bundle_selector.select(0)
	_change_to_bundle(0)
	for key in BundleManager.bundle_map.keys():
		var label: Label = Label.new()
		label.text = key
		label.autowrap_mode = TextServer.AUTOWRAP_WORD
		all_uns_list.add_child(label)


func _change_to_bundle(index: int) -> void:
	var bundle_count: int = BundleManager.get_bundles().size()
	var bundle: BundleRoot = BundleManager.get_bundles()[index % bundle_count]
	bundle_title.text = bundle.title
	bundle_author.text = bundle.author
	bundle_description.text = bundle.description


func _process(_delta: float) -> void:
	if Input.is_key_pressed(KEY_TAB) and Input.is_key_pressed(KEY_F3) and not visible:
		show()


func _visibility_changed() -> void:
	if not visible:
		all_uns_window.hide()
	if visible and all_uns_button.button_pressed:
		all_uns_window.show()	
