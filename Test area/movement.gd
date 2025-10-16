extends State
class_name movement

@export var player: CharacterBody2D
@export var player_id = 1
@export var SPEED = 300.0

func enter() -> void:
	var direction := Input.get_axis("move left_%s" %[player_id], "move right_%s" %[player_id])
	if direction !=0:
		velocity.x = direction * SPEED 
		$Animantis.flip_h=direction <0
		$Animantis.play("walk")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		$Animantis.play("idle")
	move_and_slide()

func exit() -> void:
	pass
	
func update(_delta: float) -> void:
	pass

func physics_update(_delta: float) -> void:
	pass
