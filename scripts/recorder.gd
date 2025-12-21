extends Node2D

@export var music: AudioStreamPlayer

var timestamps:Array[TimeStampKey]
var started:bool
var paused:bool = false
var start_time
var music_pause_time = 0
var menu_pause_time = 0
var menu_start_pause_time = 0
var menu_stop_pause_time = 0
var rewind_time = 0


func _input(event: InputEvent) -> void:
	
	if event.is_action_type():
		if started and event is InputEventKey and event.is_pressed():
			#timestamps.append({"milliseconds": Time.get_ticks_msec() - start_time - rewind_time - menu_pause_time, "action": event.as_text_keycode()})
			var timeStampKey = TimeStampKey.new()
			timeStampKey.milliseconds = Time.get_ticks_msec() - start_time - rewind_time - menu_pause_time
			timeStampKey.key = event.as_text_keycode()
			
			timestamps.append(timeStampKey)
			# - menu_pause_time ist standard 0, und somit nur relevant wenn bereits pause war
			# - rewind_time ist -...-
			
		if not started and event.is_action_pressed("Start_Recording"):
			started = true
			start_time = Time.get_ticks_msec()
			music.play()
			
		if event.is_action_pressed("Pause_Recording") and started and not paused:
			pause_recording()
			#test
			
		elif event.is_action_pressed("Pause_Recording") and paused:
			resume_recording()
			
			
		if started and event.is_action_pressed("Stop_Recording"):
			music.stop()
			started = false
			
			timestamps = clean_array(timestamps)
			
		if started and not paused and event.is_action_pressed("Rewind_5"):
			rewind(5)
			
		if not started and event.is_action_pressed("SaveBeatmap"):
			export()

#################################################################################

func clean_array(array:Array[TimeStampKey]) -> Array[TimeStampKey]:
	var new_array:Array[TimeStampKey] = []
	var used_keys:Array = ["A","S","D","J","K","L"]
	
	if not array.is_empty():
		for x in array:
			if x.key in used_keys:
				new_array.append(x)
	
	return new_array
	
func pause_recording():
	music_pause_time = music.get_playback_position() + AudioServer.get_time_to_next_mix() + AudioServer.get_output_latency()
	
	print(music_pause_time)
	
	menu_start_pause_time = Time.get_ticks_msec()
	music.stop()
	
	paused = true

func resume_recording():
	music.play()
	music.seek(music_pause_time)
	
	menu_stop_pause_time = Time.get_ticks_msec()
	menu_pause_time += menu_stop_pause_time - menu_start_pause_time
	print("Die insgesamt pausierte Zeit ist: ", menu_pause_time)
	
	paused = false
	
	#resetten falls erneute pause:
	menu_stop_pause_time = 0
	menu_start_pause_time = 0
	

func rewind(time_ms):
	var current_music_time = music.get_playback_position() + AudioServer.get_time_to_next_mix() + AudioServer.get_output_latency()
	
	if time_ms >= current_music_time:
		music.stop()
		music.play()
		
		var diff = time_ms - current_music_time
		rewind_time+=diff
		
		print("Es wurde um ", diff, " Sekunden rewinded")
	
	else:
		current_music_time -= time_ms
		music.stop()
		music.play()
		music.seek(current_music_time)
		
		rewind_time += time_ms
		
		print("Es wurde um ", time_ms, " Sekunden rewinded")
		
func export():
	
	var beatmap = Beatmap.new()
	beatmap.data = timestamps
	
	ResourceSaver.save(beatmap, "res://assets/beatmaps/test.tres")
	print("Saved")
