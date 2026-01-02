extends AudioStreamPlayer

@export var reprises: Dictionary[SceneManager.LevelIds, StreamWithVolume]

var start_volume: float = -40
@export var time_until_max_volume: float = 0.5

var target_db: float = 0.0
var db_incr_rate: float

func _ready() -> void:
	var stream_settings: StreamWithVolume = reprises[ManagerGlobal.currentLevel]
	stream = stream_settings.stream
	target_db = stream_settings.volume_db
	
	if ManagerGlobal.victory:
		volume_db = start_volume
		db_incr_rate = (target_db - start_volume) / time_until_max_volume
		play()

func _process(delta: float) -> void:
	if volume_db < target_db:
		volume_db += delta * db_incr_rate
		
		if volume_db > target_db:
			volume_db = target_db
	
