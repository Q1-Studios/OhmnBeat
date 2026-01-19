extends Node2D
class_name HitBarManager

@export var beatMap:Beatmap
@export var restartHoldRequirement: float = 1.5

@export var bar1:HitBar
@export var bar2:HitBar
@export var bar3:HitBar
@export var bar4:HitBar
@export var bar5:HitBar
@export var bar6:HitBar
@export var music:AudioStreamPlayer
@export var progressBar:TextureProgressBar

signal perfectSignal
signal okSignal
signal missSignal

#Points
const PERFECTPOINTS:int = 300
const OKPOINTS:int = 200
var points:int = 0

#End screen counters
var perfectAmount:int = 0
var okAmount:int = 0
var missAmount:int = 0

#Health
const DAMAGE:int = 10
const RECOVER:int = 5
var health:int = 100

#Music/God function
@onready var beatMapLength: int = beatMap.data.size()
@onready var musicLatency:float = AudioServer.get_output_latency()
@onready var globalStartTime:float = Time.get_unix_time_from_system()
var enemyTracker:int = 0
var hasStarted:bool = false

#Progressbar
@onready var songLength: float = music.stream.get_length()
var currentSongProgress:float = 0

# Restart holding duration
var restartHeldTime: float = 0

#TODO
# would be nice if we could add hexagon rotation as a next level gimmick


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("Restart"):
		restartHeldTime += delta
		if restartHeldTime >= restartHoldRequirement:
			health = 0
	else:
		restartHeldTime = 0
	
	if not hasStarted and Time.get_unix_time_from_system() >= globalStartTime + 3:
		music.play()
		hasStarted = true
	
	if currentSongProgress <= 1 and hasStarted:
		#print("currentTime in seconds", currentTimeMs)
		#print("songLength")
		currentSongProgress = music.get_playback_position() / songLength
		#print("progress", currentSongProgress)
	
	if enemyTracker < beatMapLength:
		var currentEnemyKey = beatMap.data[enemyTracker].key
		var currentEnemyTime = beatMap.data[enemyTracker].milliseconds 
		var currentMusicTime = int(1000 * get_playback_position())
		
		var spawnTime: int = currentEnemyTime - 2000 # Enemy spawns 2000ms before it hits the bar
		if (currentMusicTime >= spawnTime):
			# erstes hit object darf nicht < 2000ms sein
			
			var perfectTime: float = float(currentEnemyTime) / 1000
			
			if get_playback_position() < perfectTime:
				match currentEnemyKey:
					"S":
						bar1.spawnEnemy(perfectTime)
					"D":
						bar2.spawnEnemy(perfectTime)
					"L":
						bar3.spawnEnemy(perfectTime)
					"K":
						bar4.spawnEnemy(perfectTime)
					"J":
						bar5.spawnEnemy(perfectTime)
					"A":
						bar6.spawnEnemy(perfectTime)
					_:
						print("Invalid key name in beatmap")
			else:
				print("Dropped enemy (would be spawned after its hit time)")
			
			enemyTracker += 1

func resync_enemies() -> void:
	bar1.resync_enemies()
	bar2.resync_enemies()
	bar3.resync_enemies()
	bar4.resync_enemies()
	bar5.resync_enemies()
	bar6.resync_enemies()

func _on_bar_perfect_hit() -> void:
	print("bar1 perfect")
	#$Bar/PerfectBar/Line2D/AnimationPlayer.play("blinkspecial")
	perfectHit()

func _on_bar_ok_inner_hit() -> void:
	print("bar1 ok")
	#$Bar/PerfectBar/Line2D/AnimationPlayer.play("blink")
	okHit()

func _on_bar_ok_outer_hit() -> void:
	print("bar1 ok")
	#$Bar/PerfectBar/Line2D/AnimationPlayer.play("blink")
	okHit()

func _on_bar_no_hit() -> void:
	#$Bar/PerfectBar/Line2D/AnimationPlayer.play("failedhit")
	missed()

func missed():
	if health > 0:
		health -= DAMAGE
		health = clamp(health, 0, 100)
		print("Missed! Current Health: ", health)
		missAmount += 1
		ManagerGlobal.missAmount = missAmount
		missSignal.emit()
		$"Miss_Great_Perfect/MISS".show()
		$"Miss_Great_Perfect/PERFECT".hide()
		$"Miss_Great_Perfect/GREAT".hide()
		$Miss_Great_Perfect/MISS/AnimationPlayer.play("swobble")

func okHit():
	if health > 0:
		points += OKPOINTS
		ManagerGlobal.points = points
		okAmount += 1
		ManagerGlobal.okAmount = okAmount
		okSignal.emit()
		$"Miss_Great_Perfect/MISS".hide()
		$"Miss_Great_Perfect/PERFECT".hide()
		$"Miss_Great_Perfect/GREAT".show()
		$Miss_Great_Perfect/GREAT/AnimationPlayer.play("swobble")

func perfectHit():
	if health > 0:
		health += RECOVER
		health = clamp(health, 0, 100)
		print("Perfect! Current Health: ", health)
		points += PERFECTPOINTS
		ManagerGlobal.points = points
		perfectAmount += 1
		ManagerGlobal.perfectAmount = perfectAmount
		perfectSignal.emit()
		$"Miss_Great_Perfect/MISS".hide()
		$"Miss_Great_Perfect/PERFECT".show()
		$"Miss_Great_Perfect/GREAT".hide()
		$Miss_Great_Perfect/PERFECT/AnimationPlayer.play("swobble")

func get_playback_position() -> float:
	return music.get_playback_position() + AudioServer.get_time_to_next_mix() + musicLatency

func _on_quit_level_btn_pressed() -> void:
	health = 0
