extends Node
class_name ButtonSoundPlayer

@onready var parent_btn: ButtonPreset = $".."

@export var click_sfx: AudioStreamPlayer
@export var hover_sfx: AudioStreamPlayer

func _ready() -> void:
	if parent_btn is ButtonPreset:
		parent_btn.mouse_entered.connect(_on_mouse_entered)
		parent_btn.pressed.connect(_on_pressed)

func _on_mouse_entered() -> void:
	if parent_btn.selectable:
		hover_sfx.play()
	
func _on_pressed() -> void:
	click_sfx.play()
