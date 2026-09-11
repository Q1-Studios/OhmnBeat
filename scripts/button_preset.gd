extends Button
class_name ButtonPreset

@export var selected_modulate: Color = Color(1.5, 0.8, 0.2)

@onready var default_modulate: Color = modulate

var selected: bool = false
@export var selectable: bool = true

var mouse_inside: bool = false

func _ready() -> void:
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	focus_entered.connect(_on_focus_entered)
	focus_exited.connect(_on_focus_exited)
	pressed.connect(_on_pressed)

func _on_mouse_entered() -> void:
	if is_visible_in_tree() and selectable:
		mouse_inside = true
		Vibration.gui_tap()
		grab_focus()
	
func _on_mouse_exited() -> void:
	mouse_inside = false
	release_focus()

func _on_focus_entered() -> void:
	if selectable:
		modulate = selected_modulate
		select()

func _on_focus_exited() -> void:
	modulate = default_modulate
	unselect()

func _on_pressed() -> void:
	press()

func set_selectable(value: bool) -> void:
	selectable = value
	_on_mouse_exited()

# Inheriting classes should implement these
func press() -> void:
	pass

func select() -> void:
	pass

func unselect() -> void:
	pass
