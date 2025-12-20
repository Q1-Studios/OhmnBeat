extends Node2D
@export var beatMap:Beatmap

@export var bar1:Node2D
@export var bar2:Node2D
@export var bar3:Node2D
@export var marker:Marker2D

var PERFECTPOINTS:int = 300
var OKPOINTS:int = 200
var DAMAGE:int = 10
var health:int = 100
var points:int = 0
#TODO
# would be nice if we could add hexagon rotation as a next level gimmick


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	bar1.enemyDestination = marker.position
	bar1.keyName = "Hex1"
	bar2.enemyDestination = marker.position
	bar2.keyName = "Hex2"
	bar3.enemyDestination = marker.position
	bar3.keyName = "Hex3"

	print(bar1.enemyDestination)
	for x in beatMap.data:
		pass
		#print(x.milliseconds)
		#print(x.key)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	
	pass


func _on_bar_perfect_hit() -> void:
	print("bar1 perfect")
	points += PERFECTPOINTS
func _on_bar_ok_inner_hit() -> void:
	print("bar1 ok")
	points += OKPOINTS
func _on_bar_ok_outer_hit() -> void:
	print("bar1 ok")
	points += OKPOINTS


func _on_bar_2_perfect_hit() -> void:
	print("bar2 perfect")
	points += PERFECTPOINTS
func _on_bar_2_ok_outer_hit() -> void:
	print("bar2 ok")
	points += OKPOINTS
func _on_bar_2_ok_inner_hit() -> void:
	print("bar2 ok")
	points += OKPOINTS
	
func _on_bar_3_perfect_hit() -> void:
	print("bar3 perfect")
	points += PERFECTPOINTS
func _on_bar_3_ok_outer_hit() -> void:
	print("bar3 ok")
	points += OKPOINTS
func _on_bar_3_ok_inner_hit() -> void:
	print("bar3 ok")
	points += OKPOINTS

func _on_bar_no_hit() -> void:
	missed()

func _on_bar_2_no_hit() -> void:
	missed()

func _on_bar_3_no_hit() -> void:
	missed()

func missed():
	print("miss")
	print("Health: ")
	health -= DAMAGE
	health = clamp(health, 0, 100)
	print(health)
	print("")
	
func okHit():
	points += OKPOINTS
