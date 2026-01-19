extends Label

@export var titles: Dictionary[SceneManager.LevelIds, String]

func _ready() -> void:
	text = titles[ManagerGlobal.currentLevel]
