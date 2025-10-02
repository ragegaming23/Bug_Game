extends State

@export var player: CharacterBody2D
@export var player_id = 1
@export var SPEED = 300.0
@export var JUMP_VELOCITY = -400.0
const is_on_floor()

func enter() -> void:
	if Input.is_action_just_pressed("jump_%s" %[player_id]) and is_on_floor():
		$Animantis.play("jump")
		velocity.y = JUMP_VELOCITY
		get_node("Area2D/CollisionShape2D").disabled = false
		await get_tree().create_timer(1.0).timeout
		#$Animantis.stop("jump")
		get_node("Area2D/CollisionShape2D").disabled = true

func _process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

func _physics_process(delta) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
