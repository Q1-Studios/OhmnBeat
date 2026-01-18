extends Node2D
class_name HitBar

@export var keyName: String
@export_group("internal")
@export var okInnerBar:SuccessZone
@export var okOuterBar:SuccessZone
@export var perfectBar:SuccessZone
@export var enemySpawn:Marker2D

@onready var animationPlayer: AnimationPlayer = $PerfectBar/Line2D/AnimationPlayer
@onready var manager: HitBarManager = $".."

signal perfectHit
signal okInnerHit
signal okOuterHit
signal noHit

var randomEnemyOffsetX: int
var enemyDestination: Vector2
var enemyScene: PackedScene = preload("res://scenes/enemy.tscn")
var allEnemiesList: Array[Enemy] = []

# Time in seconds of an allowed offset for a perfect/ok hit.
# If either timing or collision indicates a hit, it counts as a hit, see below
# The values are derived from approximate measurements and shouldn't offer more leniency than collision checks
const perfect_tolerance: float = 0.15
const ok_tolerance: float = 0.35


func _input(event: InputEvent) -> void:
	if event.is_action_pressed(keyName):
	#if event is InputEventKey and event.is_pressed() and event.as_text_keycode() == keyName:
		#print(keyName)
		evaluate_hits()

func _on_touch_screen_button_pressed() -> void:
	Vibration.beat_tap()
	evaluate_hits()

func evaluate_hits() -> void:
	if area_hit(perfectBar.enemyList) or timing_hit(perfect_tolerance):
		perfectHit.emit()
		animationPlayer.play("blinkspecial")
	elif area_hit(okInnerBar.enemyList) or timing_hit(ok_tolerance):
		okInnerHit.emit()
		animationPlayer.play("blink")
	elif area_hit(okOuterBar.enemyList):
		okOuterHit.emit()
		animationPlayer.play("blink")
	else:
		noHit.emit()
		animationPlayer.play("failedhit")

# Timing-based hit validation
# Is accurate in-between frames, while collision validation is not necessarily
# Useful when the game lags (especially on low-end devices)
func timing_hit(tolerance: float) -> bool:
	var timing_based_hit: bool = false
	for enemy in allEnemiesList:
		var distance_to_perfect: float = abs(enemy.perfectTime - manager.get_playback_position())
		if distance_to_perfect <= tolerance:
			timing_based_hit = true
			print("Timing-based hit")
			erase_enemy(enemy)
	return timing_based_hit

# Collision-based hit validation
func area_hit(targetList:Array) -> bool:
	var containsEnemy: bool = !targetList.is_empty()
	for enemy in targetList:
		erase_enemy(enemy)
	return containsEnemy

func erase_enemy(enemy: Enemy) -> void:
	perfectBar.enemyList.erase(enemy)
	okInnerBar.enemyList.erase(enemy)
	okOuterBar.enemyList.erase(enemy)
	allEnemiesList.erase(enemy)
	enemy.queue_free()

func spawnEnemy(perfect_time: float) -> void:
	var instance: Enemy = enemyScene.instantiate()
	#randomEnemyOffsetX = randi_range(-20, 20)
	#instance.position.x = randomEnemyOffsetX
	instance.position.y = -50
	instance.endPosition = $PerfectBar.position
	instance.speed = 0.5
	instance.perfectTime = perfect_time
	
	# Since an enemy may be spawned "too late", compensate this latency
	instance.resync_progress(manager.get_playback_position())
	
	allEnemiesList.append(instance)
	add_child(instance)

func _on_miss_bar_missed(enemy: Enemy) -> void:
	noHit.emit()
	erase_enemy(enemy)
