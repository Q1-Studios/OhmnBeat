extends Node2D
class_name HitBarManager

@export var beatMap: Beatmap
@export var music: AudioStreamPlayer
@export var progressBar: TextureProgressBar
@export var restartHoldRequirement: float = 1.5
@export var barList: Array[HitBar] = []

@export_group("MissGreatPerfect Indicators")
@export var miss: CanvasItem
@export var great: CanvasItem
@export var perfect: CanvasItem
@export var miss_animation: AnimationPlayer
@export var great_animation: AnimationPlayer
@export var perfect_animation: AnimationPlayer

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
		var currentMusicTime = int(1000 * get_playback_position())
		var currentEnemy: TimeStampKey = beatMap.data[enemyTracker]
		
		while (enemyTracker < beatMapLength and
		currentMusicTime >= currentEnemy.milliseconds - 2000): # Enemy spawns 2000ms before it hits the bar
			
			var perfectTime: float = float(currentEnemy.milliseconds) / 1000
			
			if get_playback_position() < perfectTime:
				# Iterate through all bars, spawn enemy where beatmap key matches bar
				var keyMatch: bool = false
				for bar in barList:
					if currentEnemy.key == bar.keyName:
						bar.spawnEnemy(perfectTime)
						keyMatch = true
						break
				if not keyMatch:
					print("Invalid key name in beatmap: " + currentEnemy.key)
			else:
				print("Dropped enemy (would be spawned after its hit time)")
			
			enemyTracker += 1
			if enemyTracker < beatMapLength:
				currentEnemy = beatMap.data[enemyTracker]

func resync_enemies() -> void:
	for bar in barList:
		bar.resync_enemies()

func _on_bar_perfect_hit() -> void:
	perfectHit()

func _on_bar_ok_inner_hit() -> void:
	okHit()

func _on_bar_ok_outer_hit() -> void:
	okHit()

func _on_bar_no_hit() -> void:
	missed()

func missed():
	if health > 0:
		health -= DAMAGE
		health = clamp(health, 0, 100)
		print("Missed! Current Health: ", health)
		missAmount += 1
		ManagerGlobal.missAmount = missAmount
		missSignal.emit()
		
		miss.show()
		great.hide()
		perfect.hide()
		miss_animation.play("swobble")

func okHit():
	if health > 0:
		points += OKPOINTS
		ManagerGlobal.points = points
		okAmount += 1
		ManagerGlobal.okAmount = okAmount
		okSignal.emit()
		
		miss.hide()
		great.show()
		perfect.hide()
		great_animation.play("swobble")

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
		
		miss.hide()
		great.hide()
		perfect.show()
		perfect_animation.play("swobble")

func get_playback_position() -> float:
	return music.get_playback_position() + AudioServer.get_time_to_next_mix() + musicLatency

func _on_quit_level_btn_pressed() -> void:
	health = 0
