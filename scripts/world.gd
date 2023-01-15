extends Node2D


@export_range(0,400,.1) var pipe_velocity: int = 200

@onready var camera = $Camera2D
@onready var pipes:Array = [$Pipe1, $Pipe2, $Pipe3, $Pipe4, $Pipe5]
@onready var player = $Player

@onready var label_points = $CanvasLayer/Control/LabelPoints
@onready var label_dead = $CanvasLayer/Control/Panel/LabelDead
@onready var label_title = $CanvasLayer/Control/Panel/LabelTitle
@onready var button_play = $CanvasLayer/Control/Panel/ButtonPlay
@onready var button_try_again = $CanvasLayer/Control/Panel/ButtonTryAgain
@onready var menu = $CanvasLayer/Control/Panel

@onready var audio_click = $CanvasLayer/Control/AudioClick

var fart = preload("res://scenes/fart.tscn")


func _ready() -> void:
	menu.visible = true
	label_dead.visible = false
	label_title.visible = true
	button_play.visible = true
	button_try_again.visible = false

func _physics_process(delta: float) -> void:
	for i in pipes:
		if Global.player_dead or Global.paused:
			break
		i.position.x += -pipe_velocity * delta
	
	label_points.text = var_to_str(Global.points)


func _on_player_dead() -> void:
	camera.start_shake()
	Global.player_dead = true
	menu.visible = true
	label_dead.visible = true
	label_title.visible = false
	button_play.visible = false
	button_try_again.visible = true


func _on_player_fart() -> void:
	var new_fart = fart.instantiate()
	new_fart.position = player.position
	add_child(new_fart)


func _on_button_play_pressed() -> void:
	menu.visible = false
	Global.paused = false
	audio_click.play()


func _on_button_try_again_pressed() -> void:
	menu.visible = false
	Global.player_dead = false
	player.reset()
	for i in pipes:
		i.randomize_y_pos()
		var pos_x
		match pipes.find(i):
			0:
				pos_x = 519
			1:
				pos_x = 839
			2:
				pos_x = 1159
			3:
				pos_x = 1479
			4:
				pos_x = 1799
		i.position.x = pos_x
	Global.reset_points = true
	audio_click.play()
