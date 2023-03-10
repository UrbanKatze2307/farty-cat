extends Node2D


@export_range(0,400,.1) var pipe_velocity: int = 200

@onready var camera = $Camera2D
@onready var pipes:Array = [$Pipe1, $Pipe2, $Pipe3, $Pipe4, $Pipe5]
@onready var player = $Player

@onready var menu = $CanvasLayer/Control/Panel
@onready var label_points = $CanvasLayer/Control/LabelPoints
@onready var label_dead = $CanvasLayer/Control/Panel/LabelDead
@onready var label_title = $CanvasLayer/Control/Panel/LabelTitle
@onready var label_high_score = $CanvasLayer/Control/Panel/LabelHighScore
@onready var button_play = $CanvasLayer/Control/Panel/ButtonPlay
@onready var button_try_again = $CanvasLayer/Control/Panel/ButtonTryAgain

@onready var menu_shop = $CanvasLayer/Control/PanelShop
@onready var shop_cats = $CanvasLayer/Control/PanelShop/GridCats
@onready var shop_pipes = $CanvasLayer/Control/PanelShop/GridPipes
@onready var button_cat_white = $CanvasLayer/Control/PanelShop/GridCats/ButtonWhite
@onready var button_cat_orange = $CanvasLayer/Control/PanelShop/GridCats/ButtonOrange
@onready var button_cat_black = $CanvasLayer/Control/PanelShop/GridCats/ButtonBlack
@onready var button_pipe_green = $CanvasLayer/Control/PanelShop/GridPipes/ButtonGreen
@onready var button_pipe_yellow = $CanvasLayer/Control/PanelShop/GridPipes/ButtonYellow
@onready var button_pipe_red = $CanvasLayer/Control/PanelShop/GridPipes/ButtonRed

@onready var audio_click = $CanvasLayer/Control/AudioClick

var fart = preload("res://scenes/fart.tscn")


func _ready() -> void:
	menu.visible = true
	menu_shop.visible = false
	label_dead.visible = false
	label_title.visible = true
	button_play.visible = true
	button_try_again.visible = false
	shop_cats.visible = true
	shop_pipes.visible = false
	label_high_score.text = "High Score: " + var_to_str(Global.high_score)

func _physics_process(delta: float) -> void:
	for i in pipes:
		if Global.player_dead or Global.paused:
			break
		i.position.x += -pipe_velocity * delta
	
	label_points.text = var_to_str(Global.points)
	
	if menu_shop.visible:
		check_shop_items()



func check_shop_items() -> void:
	if Global.high_score >= 5:
		button_cat_black.disabled = false
		button_cat_black.get_child(2).text = "unlocked"
		button_pipe_red.disabled = false
		button_pipe_red.get_child(2).text = "unlocked"
	else:
		button_cat_black.disabled = true
		button_cat_black.get_child(2).text = "5 pts"
		button_pipe_red.disabled = true
		button_pipe_red.get_child(2).text = "5 pts"
	
	if Global.high_score >= 1:
		button_cat_orange.disabled = false
		button_cat_orange.get_child(2).text = "unlocked"
		button_pipe_yellow.disabled = false
		button_pipe_yellow.get_child(2).text = "unlocked"
	else:
		button_cat_orange.disabled = true
		button_cat_orange.get_child(2).text = "1 pts"
		button_pipe_yellow.disabled = true
		button_pipe_yellow.get_child(2).text = "1 pts"
	
	match Global.current_cat_color:
		0:
			button_cat_white.get_child(2).text = "selected"
		1:
			button_cat_orange.get_child(2).text = "selected"
			button_cat_white.get_child(2).text = "unlocked"
		2:
			button_cat_black.get_child(2).text = "selected"
			button_cat_white.get_child(2).text = "unlocked"
	
	match Global.current_pipe_color:
		0:
			button_pipe_green.get_child(2).text = "selected"
		1:
			button_pipe_yellow.get_child(2).text = "selected"
			button_pipe_green.get_child(2).text = "unlocked"
		2:
			button_pipe_red.get_child(2).text = "selected"
			button_pipe_green.get_child(2).text = "unlocked"



func _on_player_dead() -> void:
	camera.start_shake()
	Global.player_dead = true
	menu.visible = true
	label_dead.visible = true
	label_title.visible = false
	button_play.visible = false
	button_try_again.visible = true
	
	if Global.points > Global.high_score:
		Global.high_score = Global.points
		label_high_score.text = "High Score: " + var_to_str(Global.high_score)
		Global.save_data()


func _on_player_fart() -> void:
	var new_fart = fart.instantiate()
	new_fart.position = player.position
	add_child(new_fart)


func _on_button_play_pressed() -> void:
	menu.visible = false
	Global.paused = false
	if !Global.sfx_muted:
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
				pos_x = 1019
			1:
				pos_x = 1339
			2:
				pos_x = 1659
			3:
				pos_x = 1979
			4:
				pos_x = 2299
		i.position.x = pos_x
	Global.reset_points = true
	if !Global.sfx_muted:
		audio_click.play()


func _on_button_toggle_sound_pressed() -> void:
	Global.sfx_muted = !Global.sfx_muted
	if !Global.sfx_muted:
		audio_click.play()


func _on_button_toggle_music_pressed() -> void:
	match Global.music_muted:
		false:
			Music.volume_db = -80
			Global.music_muted = true
		true:
			Music.volume_db = -3
			Global.music_muted = false
	
	if !Global.sfx_muted:
		audio_click.play()


func _on_button_shop_pressed() -> void:
	menu.visible = false
	menu_shop.visible = true


func _on_button_shop_back_pressed() -> void:
	menu.visible = true
	menu_shop.visible = false
	


func _on_button_category_cats_pressed() -> void:
	shop_cats.visible = true
	shop_pipes.visible = false


func _on_button_category_pipes_pressed() -> void:
	shop_cats.visible = false
	shop_pipes.visible = true


func _on_button_cat_white_pressed() -> void:
	Global.current_cat_color = 0


func _on_button_cat_orange_pressed() -> void:
	Global.current_cat_color = 1


func _on_button_cat_black_pressed() -> void:
	Global.current_cat_color = 2


func _on_button_pipe_green_pressed() -> void:
	Global.current_pipe_color = 0


func _on_button_pipe_yellow_pressed() -> void:
	Global.current_pipe_color = 1


func _on_button_pipe_red_pressed() -> void:
	Global.current_pipe_color = 2
