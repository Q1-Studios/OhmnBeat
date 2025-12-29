extends ButtonPreset

@export var level_num: int = 1

signal level_clicked(level)
signal level_selected(level)

func press() -> void:
	if is_visible_in_tree():
		level_clicked.emit(level_num)

func select() -> void:
	level_selected.emit(level_num)
