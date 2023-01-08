extends CharacterBody2D


const JUMP_FORCE = -120
const GRAVITY = 9.81 * 30


func _physics_process(delta: float) -> void:
	velocity.y += GRAVITY * delta
	
	move_and_slide()


func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		velocity.y = JUMP_FORCE
	if Input.is_action_just_pressed("jump"):
		velocity.y = JUMP_FORCE
