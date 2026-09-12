extends ButtonPreset

signal latency_button_pressed

func press() -> void:
	latency_button_pressed.emit()
