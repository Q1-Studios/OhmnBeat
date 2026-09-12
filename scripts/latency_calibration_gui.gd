extends Node2D

@export var init_focus: Control
@export var latency_src: LatencyLine
@export var latency_sfx: AudioStreamPlayer

signal exit_latency_calibration

func _process(_delta: float) -> void:
	if(is_visible_in_tree()):
		if(!latency_sfx.playing):
			init_focus.grab_focus()
			latency_sfx.playing = true
	else:
		latency_sfx.playing = false

func _on_exit_button_pressed() -> void:
	ManagerGlobal.latency_millis = latency_src.get_latency()
	exit_latency_calibration.emit()
