extends Attack_State
class_name headbut


@export var player: CharacterBody2D
@export var animated_sprite_2d: AnimatedSprite2D


func enter() -> void:
	if Input.is_action_pressed("headbut_%s" %[player.player_id]):
		$"../../Animantis".play("headbut")
		player.MantisCross()
		await get_tree().create_timer(.4).timeout
		get_node("../../Area2D/HeadBut Damage").disabled = false
		await get_tree().create_timer(.2).timeout
		#$Animantis.stop("punch")
		get_node("../../Area2D/HeadBut Damage").disabled = true

func exit() -> void:
	pass
	
func update(_delta: float) -> void:
	if Input.is_action_just_released("headbut_%s" %[player.player_id]):
		await get_tree().create_timer(0.5).timeout
		$"..".on_child_transitioned("No_Attack")

	if Input.is_action_pressed("punch_%s" %[player.player_id]):
		$"..".on_child_transitioned("punch")
		return

	if Input.is_action_pressed("slash_%s" %[player.player_id]):
		$"..".on_child_transitioned("slash")

	if Input.is_action_pressed("multislash_%s" %[player.player_id]):
		$"..".on_child_transitioned("multislash")

	if Input.is_action_pressed("block_%s" %[player.player_id]):
		$"..".on_child_transitioned("block")
	pass

func physics_update(_delta: float) -> void:
	pass
