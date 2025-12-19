extends Line2D

@export var refreshOnAllTicks: bool = false

func _ready() -> void:
	points = PackedVector2Array([])
	impose_format_to_all_children()
	
func _process(_delta: float) -> void:
	if refreshOnAllTicks:
		impose_format_to_all_children()
		
func impose_format_to_all_children() -> void:
	for child in get_children():
		if child is not Line2D:
			continue
		child.closed = closed
		child.width = width
		child.width_curve = width_curve
		child.default_color = default_color
		child.gradient = gradient
		child.texture = texture
		child.texture_mode = texture_mode
		child.joint_mode = joint_mode
		child.begin_cap_mode = begin_cap_mode
		child.end_cap_mode = end_cap_mode
		child.sharp_limit = sharp_limit
		child.round_precision = round_precision
		child.antialiased = antialiased
