extends State

@export var player_id = 1

func enter() -> void:
	if Input.is_action_pressed("punch_%s" %[player_id]):
		$Animantis.play("punch")
		get_node("Area2D/CollisionShape2D").disabled = false
		await get_tree().create_timer(1.0).timeout
		#$Animantis.stop("punch")
		get_node("Area2D/CollisionShape2D").disabled = true
