extends CanvasItem

@export var others: Array[CanvasItem]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	for node in others:
		if node.visible:
			hide()
			return
	show()
