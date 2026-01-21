extends Attack_State


@export var player: CharacterBody2D
@export var animated_sprite_2d: AnimatedSprite2D


func enter() -> void:
	#if Input.is_action_pressed("Antiair_%s" %[player.player_id]):
	$"../../Animantis".play("antiair")
	await get_tree().create_timer(0.3).timeout
	player.MantisCross()
	

func exit() -> void:
	pass
	
func update(_delta: float) -> void:
	if Input.is_action_just_pressed("HeavyP_%s" %[player.player_id]):
		if $"../../Animantis".animation_finished:
			await get_tree().create_timer(0.3).timeout
			$"..".on_child_transitioned("No_Attack")

	if Input.is_action_pressed("block_%s" %[player.player_id]):
		$"..".on_child_transitioned("block")

func physics_update(_delta: float) -> void:
	pass
