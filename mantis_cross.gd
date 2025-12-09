extends CharacterBody2D


@export var Speed = 300

@export var direction: float
var SpawnPos: Vector2
var SpawnRot: float
var Zdex: int

func _Ready():
	
	global_position = SpawnPos
	global_rotation = SpawnRot
	z_index = Zdex
	
func _physics_process(_delta: float):
	$AnimatedSprite2D.play("Spin")
	velocity = Vector2(Speed,-Speed).rotated(direction)
	move_and_slide()
	


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		var knockback_direction = (body.global_position - global_position).normalized()
		body.apply_knockback(knockback_direction, 50.0, 1.0)
		body.Take_Damage(2)
		queue_free()
		
	else:
		if body.is_in_group("Player"):
			
			var knockback_direction = (body.global_position - global_position).normalized()
			body.apply_knockback(knockback_direction, 200.0, 1.0)
			body.Take_Damage(2)
			queue_free()
