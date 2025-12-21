extends Node2D


func _on_level1_clicked() -> void:
	get_tree().change_scene_to_packed(SceneManager.levelScene)


func _on_level2_clicked() -> void:
	pass # TODO Link to second level


func _on_level3_clicked() -> void:
	pass # TODO Link to third level
