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
var randomEnemyOffsetX: int
var enemyDestination: Vector2
var enemy = preload("res://scenes/enemy.tscn")
@onready var animationPlayer:AnimationPlayer = $PerfectBar/Line2D/AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	#if Input.is_action_just_pressed("spawnKey"):
		#spawnEnemy()
	pass

func _input(event: InputEvent) -> void:
	if event.is_action_pressed(keyName):
	#if event is InputEventKey and event.is_pressed() and event.as_text_keycode() == keyName:
		#print(keyName)
		evaluate_hits()

func _on_touch_screen_button_pressed() -> void:
	Vibration.beat_tap()
	evaluate_hits()

func evaluate_hits() -> void:
	if hit(perfectBar.enemyList):
		perfectHit.emit()
		animationPlayer.play("blinkspecial")
	elif hit(okInnerBar.enemyList):
		okInnerHit.emit()
		animationPlayer.play("blink")
	elif hit(okOuterBar.enemyList):
		okOuterHit.emit()
		animationPlayer.play("blink")
	else:
		noHit.emit()
		animationPlayer.play("failedhit")

func hit(targetList:Array):
	var containsEnemy: bool = !targetList.is_empty()
	for x in targetList:
			perfectBar.enemyList.erase(x)
			okInnerBar.enemyList.erase(x)
			okOuterBar.enemyList.erase(x)
			x.queue_free()
	return containsEnemy

func spawnEnemy():
	#print("spawn call works")
	var instance = enemy.instantiate()
	#randomEnemyOffsetX = randi_range(-20, 20)
	#instance.position.x = randomEnemyOffsetX
	instance.position.y = -50
	instance.endPosition = $PerfectBar.position
	instance.speed = 0.5
	add_child(instance)


func _on_miss_bar_missed() -> void:
	noHit.emit()
