extends Attack_State
class_name Df_block

@export var player: CharacterBody2D
@export var animated_sprite_2d: AnimatedSprite2D
@export var SPEED = 300.0


func enter() -> void:
	$"../../Dragonfly".play("Dragonfly_Block")
	pass
	
func exit() -> void:
	pass

func update(_delta: float) -> void:
	if Input.is_action_just_released("block_%s" %[player.player_id]):
		await get_tree().create_timer(0.3).timeout
		$"..".on_child_transitioned("DF_No_Attack")

func physics_update(_delta: float) -> void:
	pass
