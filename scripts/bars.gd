extends Node2D
@export var keyName: String
@export_group("internal")
@export var okInnerBar:SuccessZone
@export var okOuterBar:SuccessZone
@export var perfectBar:SuccessZone
@export var enemySpawn:Marker2D

signal perfectHit
signal okInnerHit
signal okOuterHit
signal noHit
var enemyDestination: Vector2
var enemy = preload("res://scenes/enemy.tscn")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#spawnEnemy()
	pass

func _input(event: InputEvent) -> void:
	if event.is_action_pressed(keyName):
	#if event is InputEventKey and event.is_pressed() and event.as_text_keycode() == keyName:
		print(keyName)
		if hit(perfectBar.enemyList):
			perfectHit.emit()
		elif hit(okInnerBar.enemyList):
			okInnerHit.emit()
		elif hit(okOuterBar.enemyList):
			okOuterHit.emit()
		else:
			noHit.emit()
			

func hit(targetList:Array):
	var containsEnemy: bool = !targetList.is_empty()
	for x in targetList:
			perfectBar.enemyList.erase(x)
			okInnerBar.enemyList.erase(x)
			okOuterBar.enemyList.erase(x)
			x.queue_free()
	return containsEnemy

func spawnEnemy():
	#if Input.is_action_just_pressed("spawnKey"):
	#print("spawn call works")
	var instance = enemy.instantiate()
	instance.position.y = -50
	instance.endPosition = $MissBar.position
	instance.speed = 0.1
	add_child(instance)
