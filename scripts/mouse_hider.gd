extends Node

var last_frame_window_focus: bool = false

func _ready() -> void:
	hide_mouse()

func _process(_delta: float) -> void:
	if get_window().has_focus() and not last_frame_window_focus:
		hide_mouse()
	
	last_frame_window_focus = get_window().has_focus()

func hide_mouse() -> void:
	# Force refresh of mouse mode (workaround on macOS)
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
