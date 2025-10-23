extends State
class_name movement

@export var player: CharacterBody2D
@export var animated_sprite_2d: AnimatedSprite2D
@export var player_id = 1
@export var SPEED = 300.0
#var direction := Input.get_axis("move left_%s" %[player_id], "move right_%s" %[player_id])

func enter() -> void:
	#$"../../Animantis".flip_h=direction <0
	$"../../Animantis".play("walk")

func exit() -> void:
	pass
	
func update(_delta: float) -> void:
	if Input.is_action_just_released("move left_%s" %[player_id]):
		player.velocity.x = move_toward(player.velocity.x, 0, SPEED)
		$"..".on_child_transitioned("idle")
		#return
	if Input.is_action_just_released("move right_%s" %[player_id]):
		player.velocity.x = move_toward(player.velocity.x, 0, SPEED)
		$"..".on_child_transitioned("idle")
	pass

func physics_update(_delta: float) -> void:
	var direction := Input.get_axis("move left_%s" %[player_id], "move right_%s" %[player_id])
	if direction !=0:
		player.velocity.x = direction * SPEED 
		$"../../Animantis".flip_h=direction <0
	player.move_and_slide()
	pass
