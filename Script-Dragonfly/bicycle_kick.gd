extends Attack_State
class_name BicycleKick

@export var player: CharacterBody2D
@export var animated_sprite_2d: AnimatedSprite2D
@export var player_id = 1
@export var SPEED = 300.0


func enter() -> void:
	$"../../Dragonfly".play("Dragonfly_Idle")
	pass
	
func exit() -> void:
	pass

func update(_delta: float) -> void:
	if Input.is_action_pressed("punch_%s" %[player_id]):
		$"..".on_child_transitioned("jab")
		return

	if Input.is_action_pressed("bicyclekick_%s" %[player_id]):
		$"..".on_child_transitioned("bicyclekick")

	if Input.is_action_pressed("spearthrow_%s" %[player_id]):
		$"..".on_child_transitioned("spearthrow")

	if Input.is_action_pressed("spear_spin_%s" %[player_id]):
		$"..".on_child_transitioned("spearspin")

	if Input.is_action_pressed("winddust_%s" %[player_id]):
		$"..".on_child_transitioned("WindDust")

	if Input.is_action_pressed("block_%s" %[player_id]):
		$"..".on_child_transitioned("block")

func physics_update(_delta: float) -> void:
	pass
