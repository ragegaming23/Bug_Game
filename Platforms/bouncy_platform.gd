extends StaticBody2D


var Knockback: Vector2 = Vector2.ZERO
@export var Knockback_timer: float = 0.0
@export var Force: float

func apply_knockback(knockbackDirection: Vector2, force: float, knockback_duration: float) -> void:
	Knockback = knockbackDirection * force
	Knockback_timer = knockback_duration


func _on_area_2d_body_entered(body: Node2D) -> void:
	$Mushroom.play("Bounce")
	var knockback_direction = (body.global_position - global_position).normalized()
	body.apply_knockback(knockback_direction, Force, 0.1)
