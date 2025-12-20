extends Node2D
@export var keyName: String
@export_group("internal")
@export var okInnerBar:SuccessZone
@export var okOuterBar:SuccessZone
@export var perfectBar:SuccessZone
signal perfectHit

var enemy = preload("res://scenes/enemy.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var instance = enemy.instantiate()
	instance.position.y = -100
	instance.endPosition = to_local(Vector2(0.0, 0.0))
	instance.speed = 0.1
	add_child(instance)
	print(position)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.is_pressed() and event.as_text_keycode() == keyName:
		if hit(perfectBar.enemyList):
			perfectHit.emit()
		if hit(okInnerBar.enemyList):
			okInnerBar.emit()
		if hit(perfectBar.enemyList):
			perfectHit.emit()
		


func hit(targetList:Array):
	var containsEnemy: bool = !targetList.is_empty()
	for x in targetList:
			perfectBar.enemyList.erase(x)
			okInnerBar.enemyList.erase(x)
			okOuterBar.enemyList.erase(x)
			x.queue_free()
	return containsEnemy
