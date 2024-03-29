extends CharacterBody2D


signal dead
signal fart

const JUMP_FORCE = -480
const GRAVITY = 9.81 * 120

@onready var sprite = $AnimatedSprite2D
@onready var audio_fart = $AudioFart


func _ready() -> void:
	randomize()


func _physics_process(delta: float) -> void:
	$AnimatedSprite2D.modulate = Global.cat_colors[Global.current_cat_color]
	
	if Global.player_dead or Global.paused:
		sprite.stop()
		return
	else:
		sprite.play()
	
	velocity.y += GRAVITY * delta
	
	move_and_slide()
	if position.y < 28:
		position.y = 28
	
	rotation_degrees = velocity.y / 18


func _input(_event: InputEvent) -> void:
	if Global.player_dead or Global.paused:
		return
	
	if Input.is_action_just_pressed("jump"):
		velocity.y = JUMP_FORCE
		if !Global.sfx_muted:
			audio_fart.pitch_scale = randf_range(0.6, 1.4)
			audio_fart.play()
		emit_signal("fart")



func reset() -> void:
	position.y = 360
	velocity.y = 0



func _on_area_2d_body_entered(_body: Node2D) -> void:
	emit_signal("dead")
