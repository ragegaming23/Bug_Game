extends Attack_State
class_name WindDust

@export var player: CharacterBody2D
@export var animated_sprite_2d: AnimatedSprite2D
@export var player_id = 1
@export var SPEED = 300.0


func enter() -> void:
	$"../../Dragonfly".play("WindDust")
	pass
	
func exit() -> void:
	pass

func update(_delta: float) -> void:
	if Input.is_action_just_released("winddust_%s" %[player_id]):
		await get_tree().create_timer(0.3).timeout
		$"..".on_child_transitioned("DF_No_Attack")
		return

	if Input.is_action_pressed("bicyclekick_%s" %[player_id]):
		$"..".on_child_transitioned("BicycleKick")

	if Input.is_action_pressed("spearthrow_%s" %[player_id]):
		$"..".on_child_transitioned("SpearThrow")

	if Input.is_action_pressed("spear_spin_%s" %[player_id]):
		$"..".on_child_transitioned("SpearSpin")

	if Input.is_action_pressed("punch_%s" %[player_id]):
		$"..".on_child_transitioned("Jab")

	if Input.is_action_pressed("block_%s" %[player_id]):
		$"..".on_child_transitioned("Block")

func physics_update(_delta: float) -> void:
	pass
