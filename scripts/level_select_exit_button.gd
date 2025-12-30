extends ButtonPreset

@export var root: LevelSelectGUI

signal exit_level_select

func _process(_delta: float) -> void:
	if is_visible_in_tree() and root.allow_exit and Input.is_action_just_pressed("ui_cancel"):
		grab_focus()
		exit_level_select.emit()

func press() -> void:
	if root.allow_exit:
		exit_level_select.emit()
