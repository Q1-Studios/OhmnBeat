extends VBoxContainer

@onready var parent_btn: SelectableLevel = $'..'

@export_group("Internal")
@export var score: Label
@export var status: Label
@export var checkmark_container: Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ManagerGlobal.updated_savegame.connect(_on_updated_savegame)
	_on_updated_savegame()

func _on_updated_savegame() -> void:
	score.text = "0 Pts"
	status.text = ""
	checkmark_container.hide()
	
	var level_id: SceneManager.LevelIds = parent_btn.level_config.level_id
	var score_record: ScoreRecord = ManagerGlobal.get_highscore(level_id)
	
	score.text = str(score_record.score, " Pts")
	if(score_record.complete):
		status.text = "Complete"
	if(score_record.perfect):
		status.text = "Perfect"
		checkmark_container.show()
