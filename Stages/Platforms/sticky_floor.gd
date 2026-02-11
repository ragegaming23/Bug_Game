extends StaticBody2D

@export var slow: float  = 0.4
func apply_slow(SPEED:float) -> void:
	SPEED = SPEED * slow


func _on_slow_effect_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		body.apply_slow()
	else:
		if body.is_in_group("player"):
			body.apply_slow()
