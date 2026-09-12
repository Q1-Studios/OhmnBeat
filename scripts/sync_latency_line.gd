extends Line2D
class_name LatencyLine

@export var audio: AudioStreamPlayer
@export var label: Label
@export var start_screen_percentage: float = 0.5

@onready var y_distance: float = get_viewport_rect().size.y

const SPEED: int = 40

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position.y = start_screen_percentage * y_distance
	set_latency(ManagerGlobal.latency_millis)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(not is_visible_in_tree()):
		return
	if(Input.is_action_pressed("ui_up")):
		position.y -= SPEED * delta
	if(Input.is_action_pressed("ui_down")):
		position.y += SPEED * delta
	position.y = clamp(position.y, start_screen_percentage * y_distance, y_distance)


func get_latency() -> int:
	var start_pos: float = y_distance * start_screen_percentage
	var offset: float = position.y - start_pos
	var seconds_per_pixel: float = audio.stream.get_length() / y_distance
	
	var latency: int = (int)(offset * seconds_per_pixel * 1000)
	return latency

func set_latency(latency_millis: int) -> void:
	var pixels_per_second: float = y_distance / audio.stream.get_length()
	var offset: float = (latency_millis / 1000.0) * pixels_per_second
	position.y = start_screen_percentage * y_distance + offset
