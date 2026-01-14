extends Attack_State
class_name multislash


@export var player: CharacterBody2D
@export var animated_sprite_2d: AnimatedSprite2D


func enter() -> void:
	#if Input.is_action_pressed("slash_%s" %[player.player_id]):
	$"../../Animantis".play("multislash")
	await get_tree().create_timer(0.3).timeout
	get_node("../../Area2D/Slash Damage").disabled = false
	await get_tree().create_timer(0.2).timeout
	#$Animantis.stop("punch")
	get_node("../../Area2D/Slash Damage").disabled = true
	get_node("../../Area2D/MultiSlash Damage").disabled = false
	await get_tree().create_timer(.6).timeout
	#$Animantis.stop("punch")
	get_node("../../Area2D/MultiSlash Damage").disabled = true

func exit() -> void:
	pass
	
func update(_delta: float) -> void:
	if Input.is_action_just_released("slash_%s" %[player.player_id]):
		await get_tree().create_timer(2).timeout
		player.Combo = false
		$"..".on_child_transitioned("No_Attack")

	if Input.is_action_pressed("block_%s" %[player.player_id]):
		$"..".on_child_transitioned("block")
	pass

func physics_update(_delta: float) -> void:
	pass
