extends Node2D
@export var beatMap:Beatmap

@export var bar1:Node2D
@export var bar2:Node2D
@export var bar3:Node2D
@export var bar4:Node2D
@export var bar5:Node2D
@export var bar6:Node2D
@export var music:AudioStreamPlayer

var PERFECTPOINTS:int = 300
var OKPOINTS:int = 200
var DAMAGE:int = 10
var health:int = 100
var points:int = 0
var beatMapLength: int = 0
var enemyTracker:int = 0
var currentEnemyKey:String
var currentEnemyTime:int
var currentElapsedTime:int
var musicLatency:int
var currentMusicTime:int

#TODO
# would be nice if we could add hexagon rotation as a next level gimmick

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	bar1.keyName = "Hex1"
	bar2.keyName = "Hex2"
	bar3.keyName = "Hex3"
	bar4.keyName = "Hex4"
	bar5.keyName = "Hex5"
	bar6.keyName = "Hex6"
	musicLatency = AudioServer.get_output_latency()
	music.play()
	beatMapLength = beatMap.data.size()





# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if enemyTracker < beatMapLength:
			currentEnemyKey = beatMap.data[enemyTracker].key
			currentEnemyTime = beatMap.data[enemyTracker].milliseconds 
			currentElapsedTime = Time.get_ticks_msec()
			#print(beatMap.data[enemyTracker].key)
			currentMusicTime = int(1000 * (music.get_playback_position() + AudioServer.get_time_to_next_mix() + musicLatency))

			if (currentMusicTime >= currentEnemyTime - 5):
				match currentEnemyKey:
					"S":
						bar1.spawnEnemy()
						enemyTracker += 1
					"D":
						bar2.spawnEnemy()
						enemyTracker += 1
					"F":
						bar3.spawnEnemy()
						enemyTracker += 1
					"J":
						bar4.spawnEnemy()
						enemyTracker += 1
					"K":
						bar5.spawnEnemy()
						enemyTracker += 1
					"L":
						bar6.spawnEnemy()
						enemyTracker += 1
					_:
						print("waiting")


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
