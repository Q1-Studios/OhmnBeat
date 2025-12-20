extends Node2D
var startPosition:Vector2
var endPosition: Vector2
var speed: float
var progress: float = 0.0

# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	startPosition = position 
	#print("i spawned")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	progress += delta * speed
	#speed = 1 -> needs 1 second to reach goal
	#speed = 0.5 -> needs 2 seconds to reach goal
	
	#TODO
	#scale timing with distance between spawn and end
	position = lerp(startPosition, endPosition, clampf(progress, 0, 1))
	pass
