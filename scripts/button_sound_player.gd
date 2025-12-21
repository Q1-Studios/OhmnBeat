extends Node
class_name ButtonSoundPlayer

@onready var parent_area: Area2D = $".."

@export var click_sfx: AudioStreamPlayer
@export var hover_sfx: AudioStreamPlayer

func _ready() -> void:
	parent_area.area_entered.connect(_on_area_entered)

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("MouseArea"):
		hover_sfx.play()
