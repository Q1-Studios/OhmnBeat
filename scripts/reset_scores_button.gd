extends ButtonPreset


@export_multiline var danger_text: String = ""
@export var danger_modulate: Color

@export var label: Label
@export var hide_on_danger: CanvasItem

var danger_active: bool = false
var base_text: String

func _ready() -> void:
	super._ready()
	base_text = label.text

func unselect() -> void:
	no_danger()

func press() -> void:
	if !danger_active:
		danger_active = true
		label.text = danger_text
		hide_on_danger.hide()
		modulate = danger_modulate
	elif danger_active:
		ManagerGlobal.reset_game()
		modulate = selected_modulate
		no_danger()

func no_danger() -> void:
	danger_active = false
	label.text = base_text
	hide_on_danger.show()
