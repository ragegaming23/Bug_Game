extends Attack_State
class_name SpearThrow

@export var player: CharacterBody2D
@export var animated_sprite_2d: AnimatedSprite2D
@export var player_id = 1
@export var SPEED = 300.0


func enter() -> void:
	$"../../Dragonfly".play("Dragonfly_SpearThrow")
	await get_tree().create_timer(.8).timeout
	get_node("../../Area2D/SpearThrow Damage").disabled = false
	await get_tree().create_timer(.3).timeout
	#$Animantis.stop("punch")
	get_node("../../Area2D/SpearThrow Damage").disabled = true
	pass
	
func exit() -> void:
	pass

func update(_delta: float) -> void:
	if Input.is_action_pressed("punch_%s" %[player_id]):
		$"..".on_child_transitioned("Jab")
		return

	if Input.is_action_pressed("bicyclekick_%s" %[player_id]):
		$"..".on_child_transitioned("BicycleKick")

	if Input.is_action_just_released("spearthrow_%s" %[player_id]):
		await get_tree().create_timer(1).timeout
		$"..".on_child_transitioned("DF_No_Attack")

	if Input.is_action_pressed("spear_spin_%s" %[player_id]):
		$"..".on_child_transitioned("SpearSpin")

	if Input.is_action_pressed("winddust_%s" %[player_id]):
		$"..".on_child_transitioned("WindDust")

	if Input.is_action_pressed("block_%s" %[player_id]):
		$"..".on_child_transitioned("Block")

func physics_update(_delta: float) -> void:
	pass
