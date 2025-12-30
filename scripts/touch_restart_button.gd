extends TouchScreenButton

@export var press_requirement_time: float = 1.5

var pressing: bool = false
var press_duration: float = 0

signal restart_triggered

func _ready() -> void:
	if Globals.is_mobile:
		show()
	else:
		hide()

func _process(delta: float) -> void:
	if pressing:
		press_duration += delta
		if press_duration >= press_requirement_time:
			restart_triggered.emit()


func _on_pressed() -> void:
	pressing = true

func _on_released() -> void:
	pressing = false
	press_duration = 0
