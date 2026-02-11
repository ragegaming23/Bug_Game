extends StaticBody2D

@export var Slow: float
func apply_slow(slow: float) -> void:
	move_speed = move_speed * slow


func _on_slow_effect_body_entered(body: Node2D) -> void:
	body.apply_slow(Slow)


func _on_slow_effect_body_exited(body: Node2D) -> void:
	body.move_speed = 300
