extends TouchScreenButton

func _ready() -> void:
	pressed.connect(_on_pressed)
	released.connect(_on_released)
	
	if Globals.is_mobile:
		show()
	else:
		hide()

func _on_pressed() -> void:
	Vibration.gui_tap()

func _on_released() -> void:
	pass
