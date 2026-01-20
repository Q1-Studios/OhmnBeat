extends AudioStreamPlayer
class_name RepriseAudioStreamPlayer

const start_volume: float = -40
const time_until_max_volume: float = 0.5

var target_db: float = 0.0
var db_incr_rate: float

func start_reprise() -> void:
	if ManagerGlobal.victory:
		volume_db = start_volume
		db_incr_rate = (target_db - start_volume) / time_until_max_volume
		play()

func _process(delta: float) -> void:
	if playing and volume_db < target_db:
		volume_db += delta * db_incr_rate
		
		if volume_db > target_db:
			volume_db = target_db
	
