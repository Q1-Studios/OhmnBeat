extends Line2D
class_name LatencyLine

@export var audio: AudioStreamPlayer
@export var label: Label
@export var start_screen_percentage: float = 0.5
@export var pulse_color: Color = Color.DARK_RED
@export var pulse_duration: float = 0.1

@onready var y_distance: float = get_viewport_rect().size.y
@onready var default_modulate: Color = modulate

const SPEED: int = 40

var legal_mouse_init: bool = false

var last_playback_pos: float = 0
var allow_pulse: bool = true
var current_pulse_duration: float = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position.y = start_screen_percentage * y_distance
	set_latency(ManagerGlobal.latency_millis)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(not is_visible_in_tree()):
		return
	
	# Allow pulse when loop has restarted
	if last_playback_pos > audio.get_playback_position():
		allow_pulse = true
	
	# Pulse after latency time has passed
	if (allow_pulse and audio.get_playback_position() >= (get_latency() / 1000.0)):
		current_pulse_duration = 0
		modulate = pulse_color
		allow_pulse = false
	modulate = pulse_color.lerp(default_modulate, clamp(current_pulse_duration / pulse_duration, 0, 1))
	current_pulse_duration += delta
	
	if(Input.is_action_pressed("ui_up")):
		position.y -= SPEED * delta
	if(Input.is_action_pressed("ui_down")):
		position.y += SPEED * delta
	if(Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and legal_mouse_init):
		position.y = get_viewport().get_mouse_position().y
	position.y = clamp(position.y, start_screen_percentage * y_distance, y_distance)
	
	last_playback_pos = audio.get_playback_position()


func _input(event: InputEvent) -> void:
	if(event is InputEventMouseButton
	and event.button_index == MOUSE_BUTTON_LEFT
	and event.pressed):
		if(event.position.y >= start_screen_percentage * y_distance):
			legal_mouse_init = true
		else:
			legal_mouse_init = false


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
