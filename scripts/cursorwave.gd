extends Line2D

@export var size: float = 4.0
@export var wave_amplitude: float = 1.0
@export var wave_frequency: float = 0.5
@export var wave_speed: float = 6.0
@export var points_per_side: int = 45

var time: float = 0.0


func _process(delta: float) -> void:
	time += delta * wave_speed
	global_position = get_global_mouse_position()
	global_position.y += 25
	update_rippling_shape()

func update_rippling_shape() -> void:
	var new_points = []
	var v1 = Vector2(size, 0)
	var v2 = Vector2(0.0, size * 0.6)
	var v3 = Vector2(-size, 0.0)
	var v4 = Vector2(0.0, -size * 0.6)
	new_points.append_array(rippleside(v1, v2))
	new_points.append_array(rippleside(v2, v3))
	new_points.append_array(rippleside(v3, v4))
	new_points.append_array(rippleside(v4, v1))
	points = new_points

func rippleside(start: Vector2, end: Vector2) -> Array:
	var side_points = []
	var direction = (end - start).normalized()

	var normal = Vector2(-direction.y, direction.x)
	var distance = start.distance_to(end)
	
	for i in range(points_per_side):
		var t = float(i) / points_per_side
		var base_pos = start.lerp(end, t)

		var ripple = sin((t * distance * wave_frequency) - time) * wave_amplitude
		
		side_points.append(base_pos + (normal * ripple))
		
	return side_points
