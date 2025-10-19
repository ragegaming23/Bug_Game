extends State
class_name punch

@export var player: CharacterBody2D
@export var player_id = 1

func enter() -> void:
	if Input.is_action_pressed("punch_%s" %[player_id]):
		$"../../Animantis".play("punch")
		get_node("Area2D/CollisionShape2D").disabled = false
		await get_tree().create_timer(1.0).timeout
		#$Animantis.stop("punch")
		get_node("Area2D/CollisionShape2D").disabled = true

func exit() -> void:
	pass
	
func update(_delta: float) -> void:
	if (Input.get_axis("move left_%s" %[player_id], "move right_%s" %[player_id])):
		return
	pass

func physics_update(_delta: float) -> void:
	pass
