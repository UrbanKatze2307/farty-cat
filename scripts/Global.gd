@tool
extends Node


var save_file:String = "user://save.fart"


var points:int = 0
var high_score:int = 0

var player_dead:bool = false
var paused:bool = true
var reset_points:bool = false

var sfx_muted:bool = false
var music_muted:bool = false

var current_cat_color:int = 0
var current_pipe_color:int = 0

var cat_colors:Array = [
	Color(1,1,1),
	Color(1,0.67,0.39),
	Color(0.39,0.39,0.39)
]
var pipe_colors:Array = [
	Color(0.35,0.86,0.08),
	Color(1,1,0.38),
	Color(1,0.05,0.35)
]


func _ready() -> void:
	load_data()



func save_data() -> void:
	var file = FileAccess.open(save_file, FileAccess.WRITE)
	file.store_var(high_score)
	file = null

func load_data() -> void:
	if FileAccess.file_exists(save_file):
		var file = FileAccess.open(save_file, FileAccess.READ)
		high_score = file.get_var()
		file = null
