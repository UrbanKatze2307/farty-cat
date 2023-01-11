extends CharacterBody2D


signal dead
signal fart

const JUMP_FORCE = -480
const GRAVITY = 9.81 * 120

@onready var sprite = $AnimatedSprite2D


func _physics_process(delta: float) -> void:
	if Global.player_dead:
		sprite.playing = false
		return
	else:
		sprite.playing = true
	
	velocity.y += GRAVITY * delta
	
	move_and_slide()
	if position.y < 28:
		position.y = 28
	
	rotation_degrees = velocity.y / 18


func _input(event: InputEvent) -> void:
	if Global.player_dead:
		return
	
	if event is InputEventKey:
		velocity.y = JUMP_FORCE
		emit_signal("fart")
	if Input.is_action_just_pressed("jump"):
		velocity.y = JUMP_FORCE
		emit_signal("fart")


func _on_area_2d_body_entered(_body: Node2D) -> void:
	emit_signal("dead")
