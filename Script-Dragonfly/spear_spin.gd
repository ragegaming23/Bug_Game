extends Attack_State
class_name SpearSpin

@export var player: CharacterBody2D
@export var animated_sprite_2d: AnimatedSprite2D
@export var SPEED = 300.0


func enter() -> void:
	$"../../Dragonfly".play("Dragonfly_SpearSpin")
	await get_tree().create_timer(.3).timeout
	get_node("../../Area2D/SpearSpin Damage").disabled = false
	await get_tree().create_timer(1.0).timeout
	#$Animantis.stop("punch")
	get_node("../../Area2D/SpearSpin Damage").disabled = true
	pass
	
func exit() -> void:
	pass

func update(_delta: float) -> void:
	if Input.is_action_pressed("MediumK_%s" %[player.player_id]) and Input.is_action_just_pressed("HeavyP_%s" %[player.player_id]):
		$"..".on_child_transitioned("SpearThrow")

	if Input.is_action_pressed("MediumK_%s" %[player.player_id]):
		await get_tree().create_timer(1).timeout
		$"..".on_child_transitioned("DF_No_Attack")

	if Input.is_action_pressed("block_%s" %[player.player_id]):
		$"..".on_child_transitioned("Block")

func physics_update(_delta: float) -> void:
	pass
