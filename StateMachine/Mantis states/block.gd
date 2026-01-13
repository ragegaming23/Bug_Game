extends Attack_State
class_name block

@export var player: CharacterBody2D
@export var animated_sprite_2d: AnimatedSprite2D


func enter() -> void:
	if Input.is_action_pressed("block_%s" %[player.player_id]):
		$"../../Animantis".play("block")
		#get_node("../../Area2D/CollisionShape2D").disabled = false
		#await get_tree().create_timer(1.0).timeout
		#$Animantis.stop("punch")
		#get_node("../../Area2D/CollisionShape2D").disabled = true

func exit() -> void:
	pass
	
func update(_delta: float) -> void:
	if Input.is_action_just_released("block_%s" %[player.player_id]):
		await get_tree().create_timer(0.3).timeout
		$"..".on_child_transitioned("No_Attack")

func physics_update(_delta: float) -> void:
	pass
