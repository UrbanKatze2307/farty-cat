extends Node2D


@export_range(0,400,.1) var pipe_velocity: int = 200

@onready var pipes:Array = [$Pipe1, $Pipe2, $Pipe3, $Pipe4, $Pipe5]
@onready var player = $Player
@onready var label_points = $Control/LabelPoints
@onready var label_dead = $Control/LabelDead

var fart = preload("res://scenes/fart.tscn")


func _physics_process(delta: float) -> void:
	for i in pipes:
		if Global.player_dead:
			break
		i.position.x += -pipe_velocity * delta
	
	label_points.text = var_to_str(Global.points)


func _on_player_dead() -> void:
	Global.player_dead = true
	label_dead.visible = true


func _on_player_fart() -> void:
	var new_fart = fart.instantiate()
	new_fart.position = player.position
	add_child(new_fart)
