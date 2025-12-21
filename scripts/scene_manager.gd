
extends Node
#@export var menuScene:PackedScene
#@export var levelScene:PackedScene
#@export var scoreScene:PackedScene
# IDK WHY THIS IS BUGGED D:
var menuScene
var levelScene
var level2Scene
var level3Scene
var scoreScene
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	menuScene = load("res://scenes/mainmenu.tscn")
	levelScene = load("res://scenes/level.tscn")
	level2Scene = load("res://scenes/level2WithTheCurrent.tscn")
	level3Scene = load("res://scenes/level3WarpSpeed.tscn")
	scoreScene = load("res://scenes/scoreScene.tscn")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	#print(scoreScene)
	pass
