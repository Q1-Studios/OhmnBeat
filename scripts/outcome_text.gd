extends Label

@export var success_text: String
@export var failure_text: String

func _ready() -> void:
	if ManagerGlobal.victory:
		text = success_text
	else:
		text = failure_text
