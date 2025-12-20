extends Node2D

@export var highlight_color: Color = Color(1.5, 0.8, 0.2, 1.0)
@export var normal_color: Color = Color(1, 1, 1, 1)

@onready var area_2d: Area2D = $Area2D

func _ready() -> void:
	area_2d.area_entered.connect(_on_area_entered)
	area_2d.area_exited.connect(_on_area_exited)

func _on_area_entered(_other_area: Area2D) -> void:
	modulate = highlight_color

func _on_area_exited(_other_area: Area2D) -> void:
	modulate = normal_color

func _process(_delta) -> void:
	if Input.is_anything_pressed():
		if area_2d.get_overlapping_areas().size() > 0:
			handle_click()
			hide()

func handle_click() -> void:
	print("Owl interacted with via collision!")
