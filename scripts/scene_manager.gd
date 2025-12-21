
extends Node
#@export var menuScene:PackedScene
#@export var levelScene:PackedScene
#@export var scoreScene:PackedScene
# IDK WHY THIS IS BUGGED D:
var menuScene
var levelScene
var scoreScene
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	menuScene = load("res://scenes/mainmenu.tscn")
	levelScene = load("res://scenes/level.tscn")
	scoreScene = load("res://scenes/scoreScene.tscn")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	print(scoreScene)
	pass
