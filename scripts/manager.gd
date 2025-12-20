extends Node2D
@export var beatMap:Beatmap

@export var bar1:Node2D
@export var bar2:Node2D
@export var bar3:Node2D
@export var bar4:Node2D
@export var bar5:Node2D
@export var bar6:Node2D
@export var music:AudioStreamPlayer
@export var progressBar:TextureProgressBar

var PERFECTPOINTS:int = 300
var OKPOINTS:int = 200
var DAMAGE:int = 10
var RECOVER:int = 5
var health:int = 100
var points:int = 0
var beatMapLength: int = 0
var enemyTracker:int = 0
var currentEnemyKey:String
var currentEnemyTime:int
var musicLatency:int
var currentMusicTime:int
var globalStartTime:int
var hasStarted:bool = false
var currentTimeMs:float = 0
var songStartTime:float = 0
var songLength:float = 0
var currentSongProgress:float = 0
#TODO
# would be nice if we could add hexagon rotation as a next level gimmick

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	globalStartTime = Time.get_unix_time_from_system()
	songLength = int(music.stream.get_length() * 1000)
	bar1.keyName = "Hex1"
	bar2.keyName = "Hex2"
	bar3.keyName = "Hex3"
	bar4.keyName = "Hex4"
	bar5.keyName = "Hex5"
	bar6.keyName = "Hex6"
	musicLatency = AudioServer.get_output_latency()
	
	beatMapLength = beatMap.data.size()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Time.get_unix_time_from_system() - 3 >= globalStartTime and not hasStarted:
		music.play()
		songStartTime = Time.get_unix_time_from_system()
		hasStarted = true
	
	if currentSongProgress <= 1 and songStartTime != 0:
		currentTimeMs = Time.get_unix_time_from_system() - songStartTime
		currentTimeMs = currentTimeMs * 1000
		#print("currentTime in seconds", currentTimeMs)
		#print("songLength")
		currentSongProgress = currentTimeMs / songLength
		#print("progress", currentSongProgress)
	
	if enemyTracker < beatMapLength:
			currentEnemyKey = beatMap.data[enemyTracker].key
			currentEnemyTime = beatMap.data[enemyTracker].milliseconds 
			#print(beatMap.data[enemyTracker].key)
			currentMusicTime = int(1000 * (music.get_playback_position() + AudioServer.get_time_to_next_mix() + musicLatency))
			if (currentMusicTime >= currentEnemyTime - 2000):
				##erstes hit object darf nicht < 2000ms sein
				match currentEnemyKey:
					"S":
						print("Spawn")
						print(Time.get_unix_time_from_system())
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
	perfectHit()
func _on_bar_ok_inner_hit() -> void:
	print("bar1 ok")
	okHit()
func _on_bar_ok_outer_hit() -> void:
	print("bar1 ok")
	okHit()

func _on_bar_2_perfect_hit() -> void:
	print("bar2 perfect")
	perfectHit()
func _on_bar_2_ok_outer_hit() -> void:
	print("bar2 ok")
	okHit()
func _on_bar_2_ok_inner_hit() -> void:
	print("bar2 ok")
	okHit()

func _on_bar_3_perfect_hit() -> void:
	print("bar3 perfect")
	perfectHit()
func _on_bar_3_ok_outer_hit() -> void:
	print("bar3 ok")
	okHit()
func _on_bar_3_ok_inner_hit() -> void:
	print("bar3 ok")
	okHit()

func _on_bar_4_perfect_hit() -> void:
	print("bar4 perfect")
	perfectHit()
func _on_bar_4_ok_outer_hit() -> void:
	print("bar4 ok")
	okHit()
func _on_bar_4_ok_inner_hit() -> void:
	print("bar4 ok")
	okHit()

func _on_bar_5_perfect_hit() -> void:
	print("bar5 perfect")
	perfectHit()
func _on_bar_5_ok_outer_hit() -> void:
	print("bar5 ok")
	okHit()
func _on_bar_5_ok_inner_hit() -> void:
	print("bar5 ok")
	okHit()

func _on_bar_6_perfect_hit() -> void:
	print("bar6 perfect")
	perfectHit()
func _on_bar_6_ok_outer_hit() -> void:
	print("bar6 ok")
	okHit()
func _on_bar_6_ok_inner_hit() -> void:
	print("bar6 ok")
	okHit()


func _on_bar_no_hit() -> void:
	missed()
func _on_bar_2_no_hit() -> void:
	missed()
func _on_bar_3_no_hit() -> void:
	missed()
func _on_bar_4_no_hit() -> void:
	missed()
func _on_bar_5_no_hit() -> void:
	missed()
func _on_bar_6_no_hit() -> void:
	missed()



func missed():
	health -= DAMAGE
	health = clamp(health, 0, 100)
	print("Missed! Current Health: ", health)

func okHit():
	points += OKPOINTS
func perfectHit():
	health += RECOVER
	health = clamp(health, 0, 100)
	print("Perfect! Current Health: ", health)
	points += PERFECTPOINTS
