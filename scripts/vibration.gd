extends Node

var enabled: bool = true

func vibrate(duration_ms: int = 500, amplitude: float = -1.0) -> void:
	if enabled:
		Input.vibrate_handheld(duration_ms, amplitude)

func gui_tap() -> void:
	vibrate(50, 0.5)

func beat_tap() -> void:
	vibrate(20, 0.5)
