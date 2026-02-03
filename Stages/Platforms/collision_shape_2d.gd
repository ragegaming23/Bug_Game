extends CollisionShape2D

func apply_slow(SPEED:int) -> void:
	SPEED = SPEED

func _on_area_2d_body_entered(_body: Node2D) -> void:
	apply_slow(100)
