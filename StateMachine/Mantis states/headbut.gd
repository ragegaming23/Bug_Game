extends Attack_State
class_name headbut


@export var player: CharacterBody2D
@export var animated_sprite_2d: AnimatedSprite2D
@export var player_id = 1

func enter() -> void:
	if Input.is_action_pressed("headbut_%s" %[player_id]):
		$"../../Animantis".play("headbut")
		get_node("../../Area2D/CollisionShape2D").disabled = false
		await get_tree().create_timer(1.0).timeout
		#$Animantis.stop("punch")
		get_node("../../Area2D/CollisionShape2D").disabled = true

func exit() -> void:
	pass
	
func update(_delta: float) -> void:
	if Input.is_action_just_released("headbut_%s" %[player_id]):
		await get_tree().create_timer(0.5).timeout
		$"..".on_child_transitioned("No_Attack")
		
	pass

func physics_update(_delta: float) -> void:
	pass
