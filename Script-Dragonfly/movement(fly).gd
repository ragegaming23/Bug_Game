extends State
class_name Move_fly

@export var player: CharacterBody2D
@export var animated_sprite_2d: AnimatedSprite2D
@export var SPEED = 300.0
var flipped = false
#var direction := Input.get_axis("move left_%s" %[player_id], "move right_%s" %[player_id])

func enter() -> void:
	#$"../../Animantis".flip_h=direction <0
	$"../../Dragonfly".play("Dragonfly_Flying")

func exit() -> void:
	pass
	
func update(_delta: float) -> void:
	if Input.is_action_just_released("move left_%s" %[player.player_id]):
		player.velocity.x = move_toward(player.velocity.x, 0, SPEED)
		$"..".on_child_transitioned("DF_idle")
		#return
	if Input.is_action_just_released("move right_%s" %[player.player_id]):
		player.velocity.x = move_toward(player.velocity.x, 0, SPEED)
		$"..".on_child_transitioned("DF_idle")
		
	if Input.is_action_just_released("move up_%s" %[player.player_id]):
		player.velocity.y = move_toward(player.velocity.y, 0, SPEED)
		$"..".on_child_transitioned("DF_idle")
		#return
	if Input.is_action_just_released("Move down_%s" %[player.player_id]):
		player.velocity.y = move_toward(player.velocity.y, 0, SPEED)
		$"..".on_child_transitioned("DF_idle")
	pass

func physics_update(_delta: float) -> void:
	var y_direction := Input.get_axis("move up_%s" %[player.player_id],"Move down_%s" %[player.player_id])
	if y_direction !=0:
		player.velocity.y = y_direction * SPEED
	var direction := Input.get_axis("move left_%s" %[player.player_id], "move right_%s" %[player.player_id])
	if direction !=0:
		player.velocity.x = direction * SPEED 
		#$"../../Dragonfly".flip_h=direction >0
	if Input.is_action_pressed("move left_%s" %[player.player_id]):
		if !Input.is_action_pressed("move right_%s" %[player.player_id]):
			player.scale.x = -1 
		
	if Input.is_action_pressed("move right_%s" %[player.player_id]):  
		if !Input.is_action_pressed("move left_%s" %[player.player_id]):
			player.scale.x = -1 
		
	player.move_and_slide()
	pass
