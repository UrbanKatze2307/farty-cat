extends Node2D


@export_range(0,400,.1) var pipe_velocity: int = 200

@onready var pipes:Array = [$Pipe1, $Pipe2, $Pipe3, $Pipe4, $Pipe5]


func _physics_process(delta: float) -> void:
	for i in pipes:
		i.position.x += -pipe_velocity * delta


func _on_player_dead() -> void:
	get_tree().quit()
