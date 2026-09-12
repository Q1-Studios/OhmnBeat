extends Node

const SAVE_PATH = "user://savegame.tres"

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

func _ready() -> void:
	load_game()

func submit_score(level_id: SceneManager.LevelIds, new_score: ScoreRecord) -> void:
	var prev_score: ScoreRecord = highscores.get(level_id)
	
	if(prev_score == null):
		highscores.set(level_id, new_score)
		save_game()
		return
	
	var stored_score: ScoreRecord = ScoreRecord.new()
	stored_score.complete = (prev_score.complete or new_score.complete)
	stored_score.perfect = (prev_score.perfect or new_score.perfect)
	
	stored_score.score = prev_score.score
	if(new_score.score > prev_score.score):
		stored_score.score = new_score.score
	
	highscores.set(level_id, stored_score)
	save_game()

func save_game() -> void:
	var savegame: SaveGame = SaveGame.new()
	savegame.scores = highscores
	
	ResourceSaver.save(savegame, SAVE_PATH)

func load_game() -> void:
	if(ResourceLoader.exists(SAVE_PATH)):
		var savegame: SaveGame = ResourceLoader.load(SAVE_PATH, "SaveGame")
		highscores = savegame.scores
