extends State
class_name jump

@export var player: CharacterBody2D
@export var animated_sprite_2d: AnimatedSprite2D
@export var player_id = 1
@export var SPEED = 300.0
@export var JUMP_VELOCITY = -400.0
#const is_on_floor()

func enter() -> void:
	if Input.is_action_just_pressed("jump_%s" %[player_id]): #and is_on_floor():
		$"../../Animantis".play("jump")
		#velocity.y = JUMP_VELOCITY
		#get_node("Area2D/CollisionShape2D").disabled = false
		#await get_tree().create_timer(1.0).timeout
		#$Animantis.stop("jump")
		#get_node("Area2D/CollisionShape2D").disabled = true

func exit() -> void:
	pass
	
func update(_delta: float) -> void:
	if (Input.get_axis("move left_%s" %[player_id], "move right_%s" %[player_id])):
		$"..".on_child_transitioned("movement")
		return
	if Input.is_action_just_released("jump_%s" %[player_id]): #and is_on_floor():
		$"..".on_child_transitioned("idle")
		#return
	pass

func physics_update(_delta: float) -> void:
	pass
