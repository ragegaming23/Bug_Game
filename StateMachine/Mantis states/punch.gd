extends Attack_State
class_name punch

@export var player: CharacterBody2D
@export var animated_sprite_2d: AnimatedSprite2D
@export var player_id = 1

func enter() -> void:
	if Input.is_action_pressed("punch_%s" %[player_id]):
		$"../../Animantis".play("punch")
		await get_tree().create_timer(.1).timeout
		get_node("../../Area2D/Punch Damage").disabled = false
		await get_tree().create_timer(.3).timeout
		#$Animantis.stop("punch")
		get_node("../../Area2D/Punch Damage").disabled = true

func exit() -> void:
	pass
	
func update(_delta: float) -> void:
	if Input.is_action_just_released("punch_%s" %[player_id]):
		await get_tree().create_timer(0.3).timeout
		$"..".on_child_transitioned("No_Attack")

	if Input.is_action_pressed("slash_%s" %[player_id]):
		$"..".on_child_transitioned("slash")

	if Input.is_action_pressed("multislash_%s" %[player_id]):
		$"..".on_child_transitioned("multislash")

	if Input.is_action_pressed("headbut_%s" %[player_id]):
		$"..".on_child_transitioned("headbut")

	if Input.is_action_pressed("block_%s" %[player_id]):
		$"..".on_child_transitioned("block")

func physics_update(_delta: float) -> void:
	pass
