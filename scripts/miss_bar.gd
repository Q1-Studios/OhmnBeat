extends Area2D
signal missed
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	area_entered.connect(_on_area_entered)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Enemy"):
		#print("you missed")
		missed.emit()
		area.queue_free()
