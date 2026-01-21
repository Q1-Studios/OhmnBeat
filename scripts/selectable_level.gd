extends ButtonPreset

@export var level_config: LevelSelectConfig
signal level_clicked(level_config)
signal level_selected(level_config)

func press() -> void:
	if is_visible_in_tree():
		level_clicked.emit(level_config)

func select() -> void:
	level_selected.emit(level_config)
