extends State
class_name DF_Idle


@export var player: CharacterBody2D
@export var animated_sprite_2d: AnimatedSprite2D
@export var SPEED:= 0
@export var player_id = 1

func enter() -> void:
	$"../../Dragonfly".play("Dragonfly_Idle")

func exit() -> void:
	pass

func update(_delta: float) -> void:
	if (Input.get_axis("move left_%s" %[player_id], "move right_%s" %[player_id])):
		$"..".on_child_transitioned("move_fly")


func physics_update(_delta: float) -> void:
	player.move_and_slide()
	pass
