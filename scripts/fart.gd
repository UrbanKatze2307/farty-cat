extends AnimatedSprite2D


func _ready() -> void:
	frame = randi_range(0,8)


func _process(delta: float) -> void:
	rotation_degrees += 360 * delta
	position.x -= 200 * delta
	modulate.a -= 1.5 * delta


func _on_timer_timeout() -> void:
	queue_free()
