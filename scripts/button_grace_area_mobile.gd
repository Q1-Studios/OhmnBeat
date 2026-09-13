extends ButtonPreset
class_name ButtonGraceAreaMobile

@onready var actual_button: ButtonPreset = $".."

func _ready() -> void:
	super._ready()
	set_as_proxy_for(actual_button)
	if not Globals.is_mobile:
		hide()

func _process(_delta: float) -> void:
	selectable = actual_button.selectable
	disabled = actual_button.disabled

func press() -> void:
		actual_button.pressed.emit()
