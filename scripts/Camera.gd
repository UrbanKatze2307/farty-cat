extends Camera2D


var shake:bool = false

var max_offset := Vector2(100,75)
var strength:float = 0.25
var strength_power:int = 2



func _ready() -> void:
	randomize()


func _process(_delta: float) -> void:
	if shake:
		var amount = pow(strength, strength_power)
		offset.x = max_offset.x * amount * randi_range(-1, 1)
		offset.y = max_offset.y * amount * randi_range(-1, 1)


func start_shake() -> void:
	shake = true
	$Timer.start()


func _on_timer_timeout() -> void:
	shake = false
	offset = Vector2(0,0)
