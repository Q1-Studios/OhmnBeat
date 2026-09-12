extends Node

const SAVE_PATH = "user://savegame.tres"
const BACKUP_SAVE_PATH = "user://last_deleted.tres"
var savegame: SaveGame

var latency_millis: int = 0

# Variables relating to last run/score
var victory:bool
var points:int
var perfectAmount:int 
var okAmount:int 
var missAmount:int
var noHitAmount:int

var currentLevel: SceneManager.LevelIds = SceneManager.LevelIds.LEVEL1

signal updated_savegame

func _ready() -> void:
	savegame = load_game()

func get_highscore(level_id: SceneManager.LevelIds) -> ScoreRecord:
	var score_record: ScoreRecord = savegame.scores.get(level_id)
	if(score_record == null): 
		return ScoreRecord.new()
	return score_record

func submit_score(level_id: SceneManager.LevelIds, new_score: ScoreRecord) -> void:
	var prev_score: ScoreRecord = get_highscore(level_id)

	var to_store_score: ScoreRecord = ScoreRecord.new()
	to_store_score.complete = (prev_score.complete or new_score.complete)
	to_store_score.perfect = (prev_score.perfect or new_score.perfect)
	
	to_store_score.score = prev_score.score
	if(new_score.score > prev_score.score):
		to_store_score.score = new_score.score
	
	savegame.scores.set(level_id, to_store_score)
	updated_savegame.emit()
	save_game(SAVE_PATH)

func save_game(path: String) -> void:
	ResourceSaver.save(savegame, path)

func load_game() -> SaveGame:
	if(ResourceLoader.exists(SAVE_PATH)):
		return ResourceLoader.load(SAVE_PATH, "SaveGame")
	else:
		return SaveGame.new()

func reset_game():
	save_game(BACKUP_SAVE_PATH)
	
	savegame = SaveGame.new()
	updated_savegame.emit()
	
	save_game(SAVE_PATH)
