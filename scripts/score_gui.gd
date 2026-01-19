extends Control

@export var init_focus: Button

func _ready() -> void:
	init_focus.grab_focus()
