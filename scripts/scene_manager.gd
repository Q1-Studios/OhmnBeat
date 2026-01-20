extends Node
@export var menuScene:PackedScene
@export var scoreScene:PackedScene

@export var levels: Dictionary[LevelIds, PackedScene]

enum LevelIds {
	LEVEL1,
	LEVEL2,
	LEVEL3,
	LEVEL4
}

func get_level_from_id(id: LevelIds) -> PackedScene:
	return levels[id]
