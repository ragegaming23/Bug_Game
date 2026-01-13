extends Attack_State
class_name Jab

@export var player: CharacterBody2D
@export var animated_sprite_2d: AnimatedSprite2D
@export var SPEED = 300.0


func enter() -> void:
	$"../../Dragonfly".play("Dragonfly_New_Jab")
	await get_tree().create_timer(.3).timeout
	get_node("../../Area2D/Jab Damage").disabled = false
	await get_tree().create_timer(.2).timeout
	#$Animantis.stop("punch")
	get_node("../../Area2D/Jab Damage").disabled = true
	pass
	
func exit() -> void:
	pass

func update(_delta: float) -> void:
	if Input.is_action_just_released("punch_%s" %[player.player_id]):
		await get_tree().create_timer(0.3).timeout
		$"..".on_child_transitioned("DF_No_Attack")
		return

	if Input.is_action_pressed("block_%s" %[player.player_id]):
		$"..".on_child_transitioned("Block")

func physics_update(_delta: float) -> void:
	pass
