extends Node2D
class_name LevelSelectGUI

@export var transition_time: float = 1.0

@export_group("Local")
@export var init_focus: Button

var transition_target: PackedScene = null
var allow_exit: bool = false

signal transition_to_level
signal exit_level_select

func _process(delta: float) -> void:
	if transition_target != null:
		transition_time -= delta
		if transition_time <= 0:
			get_tree().change_scene_to_packed(transition_target)

func _on_level_select_shown() -> void:
	if not visible:
		init_focus.grab_focus()
		allow_exit = true

func _on_level_clicked(level_config: LevelSelectConfig) -> void:
	transition_target = SceneManager.get_level_from_id(level_config.level_id)
	transition_to_level.emit()

func _on_exit_level_select() -> void:
	if allow_exit:
		allow_exit = false
		exit_level_select.emit()
