extends Attack_State
class_name slash

@export var player: CharacterBody2D
@export var animated_sprite_2d: AnimatedSprite2D


func enter() -> void:
	if Input.is_action_pressed("slash_%s" %[player.player_id]):
		$"../../Animantis".play("slash")
		await get_tree().create_timer(.2).timeout
		get_node("../../Area2D/Slash Damage").disabled = false
		await get_tree().create_timer(.3).timeout
		#$Animantis.stop("punch")
		get_node("../../Area2D/Slash Damage").disabled = true

func exit() -> void:
	pass
	
func update(_delta: float) -> void:
	if Input.is_action_just_released("slash_%s" %[player.player_id]):
		await get_tree().create_timer(0.4).timeout
		$"..".on_child_transitioned("No_Attack")

	if Input.is_action_pressed("punch_%s" %[player.player_id]):
		$"..".on_child_transitioned("punch")

	if Input.is_action_pressed("multislash_%s" %[player.player_id]):
		$"..".on_child_transitioned("multislash")

	if Input.is_action_pressed("headbut_%s" %[player.player_id]):
		$"..".on_child_transitioned("headbut")

	if Input.is_action_pressed("block_%s" %[player.player_id]):
		$"..".on_child_transitioned("block")
	pass

func physics_update(_delta: float) -> void:
	pass
