extends Area2D

@export var selected_modulate: Color
@onready var default_modulate: Color = modulate

var selected: bool = false
var last_frame_visible: bool = false

signal level_clicked

func _ready() -> void:
	area_entered.connect(_on_area_entered)
	area_exited.connect(_on_area_exited)

func _process(_delta: float) -> void:
	if last_frame_visible and not is_visible_in_tree():
		last_frame_visible = false
	
	# If the mouse moved over this area while it was hidden, the signal will not be emitted
	# Thus, force an update if the area was just shown
	if not last_frame_visible and is_visible_in_tree():
		last_frame_visible = true
		for area in get_overlapping_areas():
			if area.is_in_group("MouseArea"):
				_on_area_entered(area)

func _on_area_entered(area: Area2D):
	if area.is_in_group("MouseArea") and is_visible_in_tree():
		selected = true
		modulate = selected_modulate
	
func _on_area_exited(area: Area2D):
	if area.is_in_group("MouseArea") and is_visible_in_tree():
		selected = false
		modulate = default_modulate

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		print(name + ": " + str(has_overlapping_areas()))
		var e: InputEventMouseButton = event
		if e.pressed and selected:
			level_clicked.emit()
