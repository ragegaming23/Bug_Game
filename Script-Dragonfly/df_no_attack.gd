extends Attack_State 
class_name df_no_attack

@export var player: CharacterBody2D
@export var animated_sprite_2d: AnimatedSprite2D
@export var SPEED = 300.0


func enter() -> void:
	$"../../Dragonfly".play("Dragonfly_Idle")
	pass
	
func exit() -> void:
	pass

func update(_delta: float) -> void:
	if Input.is_action_pressed("MediumP_%s" %[player.player_id]):
		$"..".on_child_transitioned("Jab")
		return

	if Input.is_action_pressed("HeavyK_%s" %[player.player_id]):
		$"..".on_child_transitioned("BicycleKick")

	if Input.is_action_pressed("MediumK_%s" %[player.player_id]):
		$"..".on_child_transitioned("SpearSpin")

	if Input.is_action_pressed("LightK_%s" %[player.player_id]):
		$"..".on_child_transitioned("WindDust")

	if Input.is_action_pressed("block_%s" %[player.player_id]):
		$"..".on_child_transitioned("Block")

func physics_update(_delta: float) -> void:
	pass
