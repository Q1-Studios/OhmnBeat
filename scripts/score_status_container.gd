extends VBoxContainer

@onready var parent_btn: SelectableLevel = $'..'

@export_group("Internal")
@export var score: Label
@export var status: Label
@export var checkmark_container: Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	score.text = "0 Pts"
	status.text = ""
	checkmark_container.hide()
	
	var level_id: SceneManager.LevelIds = parent_btn.level_config.level_id
	var score_record: ScoreRecord = ManagerGlobal.highscores.get(level_id)
	
	if(score_record == null):
		return
	
	score.text = str(score_record.score, " Pts")
	if(score_record.complete):
		status.text = "Complete"
	if(score_record.perfect):
		status.text = "Perfect"
		checkmark_container.show()
