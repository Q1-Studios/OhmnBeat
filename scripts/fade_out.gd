extends ColorRect
class_name FadeOutRect

@export var duration: float = 1

var fade_out: bool = false

func _ready() -> void:
	color.a = 0

func _process(delta: float) -> void:
	if color.a < 1 and fade_out:
		color.a += delta * (1/duration)

func start_fade_out() -> void:
	fade_out = true


func _on_transition_to_level() -> void:
	start_fade_out()
