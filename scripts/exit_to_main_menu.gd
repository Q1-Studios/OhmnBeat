extends ButtonPreset

func press() -> void:
	call_deferred("exit_to_menu")

func exit_to_menu() -> void:
	get_tree().change_scene_to_packed(SceneManager.menuScene)
