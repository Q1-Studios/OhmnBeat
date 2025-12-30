extends Node2D

@export var environment: WorldEnvironment

@export_group("Local")
@export var fade_out: FadeOutRect

@export var init_focus_btn: Button
@export var init_text: CanvasItem
@export var init_animation_player: AnimationPlayer

var anything_pressed = false

func _process(_delta):
	if not anything_pressed and Input.is_anything_pressed():
		init_text.hide()
		init_focus_btn.grab_focus()
		init_animation_player.play("swoopin")
		anything_pressed = true

func _on_transition_to_level() -> void:
	environment.environment.adjustment_brightness = 1.2
	fade_out.start_fade_out()

func quit_game():
	get_tree().quit()
