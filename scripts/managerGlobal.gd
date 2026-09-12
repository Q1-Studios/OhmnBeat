extends Node

var latency_millis: int = 0

# Variables relating to last run/score
var victory:bool
var points:int
var perfectAmount:int 
var okAmount:int 
var missAmount:int

var currentLevel: SceneManager.LevelIds = SceneManager.LevelIds.LEVEL1
