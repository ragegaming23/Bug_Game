extends State
class_name movement

@export var player: CharacterBody2D
@export var animated_sprite_2d: AnimatedSprite2D
@export var player_id = 1
@export var SPEED = 300.0
var flipped = true
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
	if Input.is_action_just_pressed("jump_%s" %[player_id]) and player.is_on_floor():
		$"..".on_child_transitioned("jump")
	pass

func physics_update(_delta: float) -> void:
	var direction := Input.get_axis("move left_%s" %[player_id], "move right_%s" %[player_id])
	if direction !=0:
		player.velocity.x = direction * SPEED 
		#$"../../Animantis".flip_h=direction <0
	if Input.is_action_pressed("move left_%s" %[player_id]) and flipped:
		player.scale.x = -1 
		flipped = false
	if Input.is_action_pressed("move right_%s" %[player_id]) and not flipped:
		player.scale.x = -1 
		flipped = true
	player.move_and_slide()
	
	if not player.is_on_floor():
		player.velocity += player.get_gravity() * _delta
	pass
