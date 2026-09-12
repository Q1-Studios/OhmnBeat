extends Label

@export var latency_src: LatencyLine

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	text = str(latency_src.get_latency(), " ms")
