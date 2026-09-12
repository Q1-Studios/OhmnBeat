extends ButtonPreset


signal exit

var allow_shortcut: bool = false

func _process(_delta: float) -> void:
	if is_visible_in_tree() and allow_shortcut and Input.is_action_just_pressed("ui_cancel"):
		grab_focus()
		exit.emit()
	
	if not Input.is_action_pressed("ui_cancel"):
		allow_shortcut = true

func press() -> void:
	exit.emit()
