extends Node

var latency_millis: int = 0

# Variables relating to last run/score
var victory:bool
var points:int
var perfectAmount:int 
var okAmount:int 
var missAmount:int
var noHitAmount:int

var currentLevel: SceneManager.LevelIds = SceneManager.LevelIds.LEVEL1

var highscores: Dictionary[SceneManager.LevelIds, ScoreRecord] = {}

func submit_score(level_id: SceneManager.LevelIds, new_score: ScoreRecord) -> void:
	var prev_score: ScoreRecord = highscores.get(level_id)
	
	if(prev_score == null):
		highscores.set(level_id, new_score)
		return
	
	var stored_score: ScoreRecord = ScoreRecord.new()
	stored_score.complete = (prev_score.complete or new_score.complete)
	stored_score.perfect = (prev_score.perfect or new_score.perfect)
	
	stored_score.score = prev_score.score
	if(new_score.score > prev_score.score):
		stored_score.score = new_score.score
	
	highscores.set(level_id, stored_score)
