extends State
class_name Idle

@export var player: CharacterBody2D
@export var SPEED:= 0
const is_on_floor()

func enter() -> void:
	$Animantis.play("idle")

func _process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

func _physics_process(delta) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
