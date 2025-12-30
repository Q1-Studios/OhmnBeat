extends Node2D

@export var transition_time: float = 1.0

@export_group("Local")
@export var init_focus: Button

var transition_target: PackedScene = null

signal transitioning

func _process(delta: float) -> void:
	if transition_target != null:
		transition_time -= delta
		if transition_time <= 0:
			get_tree().change_scene_to_packed(transition_target)

func _on_level_select_shown() -> void:
	init_focus.grab_focus()

func _on_level_clicked(level: int) -> void:
	match level:
		1: 
			transition_target = SceneManager.levelScene
		2:
			transition_target = SceneManager.level2Scene
		3:
			transition_target = SceneManager.level3Scene
	transitioning.emit()
