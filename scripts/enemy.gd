extends Node2D
class_name Enemy

var startPosition:Vector2
var endPosition: Vector2
var speed: float
var progress: float = 0.0
var spawn_delay_ms: int = 0
var perfectTime: float

# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	startPosition = position 
	
	# Since an enemy may be spawned "too late"
	# set the initial progress to where it would have moved during the delay
	progress = (float(spawn_delay_ms) / 1000) * speed


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	progress += delta * speed
	#speed = 1 -> needs 1 second to reach goal
	#speed = 0.5 -> needs 2 seconds to reach goal
	
	#TODO
	#scale timing with distance between spawn and end
	position = lerp(startPosition, endPosition, clampf(progress, 0, 2))

	$Wave.offset = position.y/$Wave.period
	$Wave.updatewave()
	pass
