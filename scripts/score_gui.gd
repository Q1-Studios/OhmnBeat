extends Control

@export var init_focus: Button
@export var level_settings: Dictionary[SceneManager.LevelIds, ScoreSceneSettings]

@export var title_label: Label
@export var reprise_music: RepriseAudioStreamPlayer

func _ready() -> void:
	init_focus.grab_focus()
	
	var current_settings: ScoreSceneSettings = level_settings[ManagerGlobal.currentLevel]
	title_label.text = current_settings.song_title
	reprise_music.stream = current_settings.reprise_stream
	reprise_music.target_db = current_settings.reprise_volume_db
	reprise_music.start_reprise()
