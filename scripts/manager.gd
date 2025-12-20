extends Node2D
@export var beatMap:Beatmap

@export var bar1:Node2D
@export var bar2:Node2D
@export var bar3:Node2D

#var enemy = preload("res://scenes/enemy.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for x in beatMap.data:
		print(x.milliseconds)
		print(x.key)
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	
	pass


func _on_bar_perfect_hit() -> void:
	pass # Replace with function body.
