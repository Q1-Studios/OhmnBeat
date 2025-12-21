extends Node2D

@export var transition_time: float = 1.0

var transition_target: PackedScene = null

signal transitioning

func _process(delta: float) -> void:
	if transition_target != null:
		transition_time -= delta
		if transition_time <= 0:
			get_tree().change_scene_to_packed(transition_target)

func _on_level1_clicked() -> void:
	transition_target = SceneManager.levelScene
	transitioning.emit()


func _on_level2_clicked() -> void:
	transition_target = SceneManager.level2Scene
	transitioning.emit()


func _on_level3_clicked() -> void:
	transition_target = SceneManager.level3Scene
	transitioning.emit()
