extends State 
class_name Idle


@export var player: CharacterBody2D
@export var animated_sprite_2d: AnimatedSprite2D
@export var SPEED:= 0

func enter() -> void:
	$"../../Animantis".play("idle")

func exit() -> void:
	pass

func update(_delta: float) -> void:
	if (Input.get_axis("move left_%s" %[player.player_id], "move right_%s" %[player.player_id])):
		$"..".on_child_transitioned("movement")

	if Input.is_action_just_pressed("jump_%s" %[player.player_id]) and player.is_on_floor():
		$"..".on_child_transitioned("jump")

func physics_update(_delta: float) -> void:
	if not player.is_on_floor():
		player.velocity += player.get_gravity() * _delta
	player.move_and_slide()
	pass
