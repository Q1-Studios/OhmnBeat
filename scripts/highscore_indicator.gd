extends Label

var prev_highscore: ScoreRecord

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	text = ""
	prev_highscore = ManagerGlobal.highscores.get(ManagerGlobal.currentLevel)
	var current_score = build_score_record()
	
	if(prev_highscore == null or current_score.score > prev_highscore.score):
		text = "New highscore!"
		ManagerGlobal.highscores.set(ManagerGlobal.currentLevel, current_score)
	if(current_score.perfect):
		text = "Perfect score!"

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
