extends ColorRect

@export var manager: HitBarManager

@export var paused_display: Control
@export var count_in_label: Label

const count_in: int = 4

var paused: bool = false
var unpausing: bool = false
var require_release: bool = false

var pause_time: float
var count_in_timestamps: Array[float] = []

func _process(_delta: float) -> void:
	if paused and not unpausing and Input.is_anything_pressed() and not require_release:
		start_unpause()
	elif not paused and not unpausing and Input.is_action_just_pressed("ui_cancel"):
		pause()
	
	if not paused and not unpausing and not get_window().has_focus():
		pause()
	
	# If a key was pressed in the last frame, require the key to be released
	# Otherwise, an unpause would be performed immediately after a pause
	require_release = Input.is_anything_pressed()
	
	# Display count-in for unpausing
	if unpausing:
		var counted_in: int = 0
		var playback_position: float = manager.get_playback_position()
		
		for timestamp in count_in_timestamps:
			if playback_position >= timestamp:
				counted_in += 1
		
		count_in_label.text = str(count_in - counted_in)
		
		# Unpause when either finished counting in
		# or when not enough timestamps were generated for counting in
		if counted_in == count_in or count_in_timestamps.size() != count_in:
			unpause()
			unpausing = false

func pause() -> void:
	paused = true
	get_tree().paused = true
	manager.music.stream_paused = true
	pause_time = manager.get_playback_position()
	
	paused_display.show()
	count_in_label.hide()
	show()

func start_unpause() -> void:
	unpausing = true
	
	var bpm: float = manager.music.stream.bpm
	var time_per_beat: float = 60 / bpm
	var last_beat: int = int(pause_time / time_per_beat)
	
	var last_beat_time: float = last_beat * time_per_beat
	var music_resume_time: float = last_beat_time - count_in * time_per_beat
	
	# Calculate timestamps corresponding to count-in beats
	count_in_timestamps = []
	
	# Only count in when there are enough beats to do so
	if music_resume_time >= 0:
		for i in range(1, count_in + 1):
			count_in_timestamps.append(music_resume_time + i * time_per_beat)
	else:
		music_resume_time = 0
	
	manager.music.stream_paused = false
	
	# Seek to when the game will continue and update enemy positions
	manager.music.seek(last_beat_time)
	manager.resync_enemies()
	
	# Then seek music to time when the count-in begins
	manager.music.seek(music_resume_time)
	
	paused_display.hide()
	count_in_label.show()

func unpause() -> void:
	paused = false
	hide()
	get_tree().paused = false
	manager.resync_enemies()
