extends Attack_State 
class_name no_attack

@export var player: CharacterBody2D
@export var animated_sprite_2d: AnimatedSprite2D

@export var SPEED = 300.0


func enter() -> void:
	$"../../Animantis".play("idle")
	pass
	
func exit() -> void:
	pass

func update(_delta: float) -> void:
	if Input.is_action_pressed("punch_%s" %[player.player_id]):
		$"..".on_child_transitioned("punch")
		return

	if Input.is_action_pressed("slash_%s" %[player.player_id]):
		$"..".on_child_transitioned("slash")

	if Input.is_action_pressed("multislash_%s" %[player.player_id]):
		$"..".on_child_transitioned("multislash")

	if Input.is_action_pressed("headbut_%s" %[player.player_id]):
		$"..".on_child_transitioned("headbut")

	if Input.is_action_pressed("block_%s" %[player.player_id]):
		$"..".on_child_transitioned("block")

func physics_update(_delta: float) -> void:
	pass
