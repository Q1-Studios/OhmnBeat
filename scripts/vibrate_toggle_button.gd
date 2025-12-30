extends ButtonPreset

@export var toggled_symbol: CanvasItem

func _ready() -> void:
	super._ready()
	update_symbol()
	if not Globals.is_mobile:
		hide()

func press() -> void:
	Vibration.enabled = not Vibration.enabled
	update_symbol()

func update_symbol() -> void:
	toggled_symbol.visible = Vibration.enabled
