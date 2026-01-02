extends ButtonPreset

@export var level: SceneManager.LevelIds = SceneManager.LevelIds.LEVEL1

signal level_clicked(level)
signal level_selected(level)

func press() -> void:
	if is_visible_in_tree():
		level_clicked.emit(level)

func select() -> void:
	level_selected.emit(level)
