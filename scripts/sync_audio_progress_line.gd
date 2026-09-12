extends Line2D

@export var audio: AudioStreamPlayer
@export var start_screen_percentage: float = 0.5

@onready var y_distance: float = get_viewport_rect().size.y

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position.y = start_screen_percentage * y_distance


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	var progress = (audio.get_playback_position() + AudioServer.get_time_since_last_mix()) / audio.stream.get_length()
	position.y = progress * y_distance + start_screen_percentage * y_distance
	if(position.y > y_distance):
		position.y -= y_distance
