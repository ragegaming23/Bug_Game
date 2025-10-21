extends State 
class_name Idle


@export var player: CharacterBody2D
@export var animated_sprite_2d: AnimatedSprite2D
@export var SPEED:= 0
@export var player_id = 1

func enter() -> void:
	$"../../Animantis".play("idle")

func exit() -> void:
	pass

func update(_delta: float) -> void:
	if (Input.get_axis("move left_%s" %[player_id], "move right_%s" %[player_id])):
		$"..".on_child_transitioned("movement")

	if Input.is_action_just_pressed("jump_%s" %[player_id]): #and is_on_floor():
		$"..".on_child_transitioned("jump")

	#if Input.is_action_pressed("punch_%s" %[player_id]):
		#$"..".on_child_transitioned(punch)
		#return

func physics_update(_delta: float) -> void:
	pass
