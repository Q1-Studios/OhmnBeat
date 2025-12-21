extends Area2D

@export var selected_modulate: Color
@export var default_select: bool = false

@onready var default_modulate: Color = modulate

var selected: bool = false

signal level_clicked
signal level_selected

func _ready() -> void:
	area_entered.connect(_on_area_entered)
	area_exited.connect(_on_area_exited)
	
	if default_select:
		select()

func _on_area_entered(area: Area2D):
	if area.is_in_group("MouseArea") and is_visible_in_tree():
		select()
	
func _on_area_exited(area: Area2D):
	if area.is_in_group("MouseArea"):
		selected = false
		modulate = default_modulate

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		var e: InputEventMouseButton = event
		if e.pressed and selected and is_visible_in_tree():
			level_clicked.emit()

func select():
	selected = true
	modulate = selected_modulate
	level_selected.emit()
