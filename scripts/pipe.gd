@tool
extends StaticBody2D


@export_range(0,100,.1) var gap_size:int = 0
@export_color_no_alpha var color:Color = Color(1,1,1)


func _ready() -> void:
	randomize()
	randomize_y_pos()


func _physics_process(_delta: float) -> void:
	$SpriteUp.position.y = -gap_size / 2
	$SpriteDown.position.y = gap_size / 2
	$CollisionShapeUp.position.y = -160 -gap_size / 2
	$CollisionShapeDown.position.y = 160 +gap_size / 2
	$AreaPoints/CollisionShape2D.shape.size.y = gap_size
	
	$SpriteUp.modulate = color
	$SpriteDown.modulate = color
	
	if Global.reset_points:
		Global.points = 0
		await get_tree().create_timer(0.1).timeout
		Global.reset_points = false
	
	if position.x < -46:
		position.x = 1234 + 80*4
		position.y = randi_range(160, 560)



func randomize_y_pos() -> void:
	position.y = randi_range(160, 560)



func _on_area_points_area_exited(_area: Area2D) -> void:
	Global.points += 1
