extends SubViewport

@export var manager:Node2D
@export var glitchEffectAnimationPlayer:AnimationPlayer
var allowedToGlitch:bool
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	allowedToGlitch = true
	size.x = 1920

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if allowedToGlitch:
		if manager.health == 0:
			print("no health")
			glitchEffectAnimationPlayer.play("GlitchEffectAnimation")
			allowedToGlitch = false
			size.x = 1920
	
