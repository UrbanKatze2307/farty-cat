extends AudioStreamPlayer


var tracks: Array = [
	load("res://assets/music/gbdemo2.mp3"),
	load("res://assets/music/happy_adveture.mp3"),
	load("res://assets/music/it_takes_a_hero.wav"),
	load("res://assets/music/squashin_bugs.wav"),
	load("res://assets/music/stage_2.wav")
]
var current_track: int


func _ready() -> void:
	randomize()
	current_track = randi_range(0,4)
	stream = tracks[current_track]
	play()


func get_new_track(current:int) -> int:
	print("Input: " + var_to_str(current))
	var new = randi_range(0,4)
	print("Mid Result: " + var_to_str(new))
	if new == current:
		print("Matched current, passing")
		new = get_new_track(current)
	print("Result: " + var_to_str(new))
	return new


func _on_finished() -> void:
	print("START NEW VAR")
	current_track = get_new_track(current_track)
	print("END RESULT: " + var_to_str(current_track))
	stream = tracks[current_track]
	await get_tree().create_timer(1).timeout
	play()
