extends CharacterBody2D


signal dead

const JUMP_FORCE = -480
const GRAVITY = 9.81 * 120


func _physics_process(delta: float) -> void:
	velocity.y += GRAVITY * delta
	
	move_and_slide()
	if position.y < 28:
		position.y = 28


func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		velocity.y = JUMP_FORCE
	if Input.is_action_just_pressed("jump"):
		velocity.y = JUMP_FORCE


func _on_area_2d_body_entered(body: Node2D) -> void:
	emit_signal("dead")
