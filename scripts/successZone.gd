extends Area2D
class_name SuccessZone
var enemyList:Array = []
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	area_entered.connect(_on_area_entered)
	area_exited.connect(_on_area_exited)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Enemy"):
		enemyList.append(area)
		print(enemyList)


func _on_area_exited(area: Area2D) -> void:
	if area.is_in_group("Enemy"):
		enemyList.pop_front()
		print(enemyList)
		
