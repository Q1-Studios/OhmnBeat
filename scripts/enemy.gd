extends Node2D
class_name Enemy

@export var wave: WaveLine2D

var startPosition: Vector2
var endPosition: Vector2
var speed: float
var progress: float = 0.0
var perfectTime: float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position = startPosition 

func get_duration() -> float:
	return 1 / speed

func resync_progress(currentTime: float) -> void:
	progress = 1 - ((perfectTime - currentTime) / get_duration())
	update_position()

func update_position() -> void:
	position = lerp(startPosition, endPosition, clampf(progress, 0, 2))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	progress += delta * speed
	#speed = 1 -> needs 1 second to reach goal
	#speed = 0.5 -> needs 2 seconds to reach goal
	
	update_position()
	
	wave.offset = position.y / wave.period
	wave.updatewave()
