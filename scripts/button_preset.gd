extends Button
class_name ButtonPreset

@export var selected_modulate: Color = Color(1.5, 0.8, 0.2)

@onready var default_modulate: Color = modulate

var proxy_for: ButtonPreset = self
var own_proxies: Array[ButtonPreset] = []

var selected: bool = false
@export var selectable: bool = true

var mouse_inside_self: bool = false
var button_down_self: bool = false

func _ready() -> void:
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	button_down.connect(_on_button_down)
	button_up.connect(_on_button_up)
	focus_entered.connect(_on_focus_entered)
	focus_exited.connect(_on_focus_exited)
	pressed.connect(_on_pressed)

func _on_mouse_entered() -> void:
	if is_visible_in_tree() and selectable:
		mouse_inside_self = true
		proxy_grab_focus()

func _on_mouse_exited() -> void:
	mouse_inside_self = false
	call_deferred("proxy_release_focus")

func _on_focus_entered() -> void:
	if(proxy_for != self):
		proxy_for.grab_focus()
		return
	if selectable:
		modulate = selected_modulate
		select()

func _on_focus_exited() -> void:
	call_deferred("handle_focus_exit")

func _on_pressed() -> void:
	press()

func _on_button_down() -> void:
	button_down_self = true

func _on_button_up() -> void:
	button_down_self = false
	if(not proxy_for.has_focus()):
		proxy_grab_focus()
		proxy_release_focus()

func set_selectable(value: bool) -> void:
	selectable = value
	_on_mouse_exited()

func handle_focus_exit() -> void:
	if(not proxy_has_focus() and not is_button_down()):
		modulate = default_modulate
		unselect()

func proxy_grab_focus() -> void:
	if(not proxy_for.has_focus()):
		Vibration.gui_tap()
		proxy_for.grab_focus()

func proxy_release_focus() -> void:
	if(not proxy_for.is_mouse_inside()):
		if(proxy_for.is_inside_tree()):
			proxy_for.release_focus()

func _register_proxy(proxy: ButtonPreset) -> void:
	own_proxies.append(proxy)

func set_as_proxy_for(target: ButtonPreset) -> void:
	proxy_for = target
	target._register_proxy(self)

func proxy_has_focus() -> bool:
	for proxy in own_proxies:
		if proxy.has_focus():
			return true
	return false

func is_mouse_in_proxy() -> bool:
	for proxy in own_proxies:
		if proxy.mouse_inside_self:
			return true
	return false

func is_button_down_on_proxy() -> bool:
	for proxy in own_proxies:
		if proxy.button_down_self:
			return true
	return false

func is_mouse_inside() -> bool:
	return mouse_inside_self or is_mouse_in_proxy()

func is_button_down() -> bool:
	return button_down_self or is_button_down_on_proxy()

# Inheriting classes should implement these
func press() -> void:
	pass

func select() -> void:
	pass

func unselect() -> void:
	pass
