extends Line2D

@export var subdivisions:int = 150
@export var amplitude:float = 25
@export var period:float = 1.0



@export var length:float = 15.0

enum WAVE_TYPE {SINE, TRIANGLE, SAW, SINE_WOBBLE}
@export var wavetype: WAVE_TYPE = WAVE_TYPE.SINE

var wave_functions = {
		WAVE_TYPE.SINE: get_sine_wave,
		WAVE_TYPE.TRIANGLE: get_triangle_wave,
		WAVE_TYPE.SAW: get_saw_wave,
		WAVE_TYPE.SINE_WOBBLE: get_wobble_sine_wave,
	}

var offset = 0
func _process(delta) -> void:
	var new_points = []
	for p in range(subdivisions):
		var x = p * (length / subdivisions)
		var y = wave_functions[wavetype].call((x / period) + offset, amplitude)
		new_points.append(Vector2(x,y))
	
	#position.x = offset * period


	points = new_points
	offset += 5 * delta


func get_sine_wave(x: float, amp: float) -> float:
	return sin(x) * amp


func get_triangle_wave(x: float, amp: float) -> float:
	return (pingpong(x, 2.0) - 1.0) * amp

func get_saw_wave(x: float, amp: float) -> float:
	return (fmod(x, 2.0) - 1.0) * amp

func get_wobble_sine_wave(x: float, amp: float) -> float:
	var wobble = sin(x * 0.25) * amp * 0.2 
	return sin(x + wobble) * amp
