extends Control

@export var init_focus: Button
@export var level_config: Dictionary[SceneManager.LevelIds, ScoreSceneConfig]

@export var title_label: Label
@export var reprise_music: RepriseAudioStreamPlayer

func _ready() -> void:
	init_focus.grab_focus()
	
	var current_config: ScoreSceneConfig = level_config[ManagerGlobal.currentLevel]
	title_label.text = current_config.song_title
	reprise_music.stream = current_config.reprise_stream
	reprise_music.target_db = current_config.reprise_volume_db
	reprise_music.start_reprise()
