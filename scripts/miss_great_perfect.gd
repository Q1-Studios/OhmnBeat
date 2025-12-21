extends Node2D
@export var missObject:Node2D
@export var greatObject:Node2D
@export var perfectObject:Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#missObject.hide()
	#greatObject.hide()
	#perfectObject.hide()
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_manager_miss_signal() -> void:
	#missObject.show()
	#get_tree().create_timer(0.5).timeout
	#missObject.hide()
	pass


func _on_manager_ok_signal() -> void:
	#greatObject.show()
	#get_tree().create_timer(0.1).timeout
	#greatObject.hide()
	pass


func _on_manager_perfect_signal() -> void:
	#perfectObject.show()
	#get_tree().create_timer(0.1).timeout
	#perfectObject.hide()
	pass
