extends Node

@export var time_until_hide: float = 3.0
var time_since_activity: float = 0

func _ready() -> void:
	hide_mouse()

func _process(delta: float) -> void:
	if time_since_activity < time_until_hide and get_window().has_focus():
		time_since_activity += delta
		if time_since_activity >= time_until_hide:
			hide_mouse()

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton or event is InputEventMouseMotion:
		time_since_activity = 0
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func hide_mouse() -> void:
	# Force refresh of mouse mode (workaround on macOS)
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
