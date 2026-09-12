extends Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	text = ""
	var current_level: SceneManager.LevelIds = ManagerGlobal.currentLevel
	var prev_highscore: ScoreRecord = ManagerGlobal.get_highscore(current_level)
	var current_score = build_score_record()
	
	if(current_score.score > prev_highscore.score):
		text = "New highscore!"
	if(current_score.perfect):
		text = "Perfect score!"
	ManagerGlobal.submit_score(current_level, current_score)

func build_score_record() -> ScoreRecord:
	var record: ScoreRecord = ScoreRecord.new()
	record.score = ManagerGlobal.points
	record.complete = ManagerGlobal.victory
	record.perfect = is_perfect()
	return record

func is_perfect() -> bool:
	return (
		ManagerGlobal.victory and
		ManagerGlobal.okAmount == 0 and
		ManagerGlobal.missAmount == 0 and
		ManagerGlobal.noHitAmount == 0 
	)
