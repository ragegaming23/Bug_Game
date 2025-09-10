extends CharacterBody2D 

#@onready var healthbar = get_node("res://Health Bar/health_bar.tscn")

const Name = "player"
const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var MaxHealth = 10
var Health = 10

var Knockback: Vector2 = Vector2.ZERO
var Knockback_timer: float = 0.0

#func _ready():
	#healthbar.set_health_bar(Health, MaxHealth)

func apply_knockback(knockbackDirection: Vector2, force: float, knockback_duration: float) -> void:
	Knockback = knockbackDirection * force
	Knockback_timer = knockback_duration

func _physics_process(delta: float) -> void:
	if Knockback_timer > 0.0:
		velocity = Knockback
		Knockback_timer -= delta
		if Knockback_timer <= 0.0:
			Knockback = Vector2.ZERO
	else:
		_movement(delta)
	if Input .is_action_pressed("punch"):
		$Animantis.play("punch")
		get_node("Area2D/CollisionShape2D").disabled = false
		await get_tree().create_timer(1).timeout
		#$Animantis.stop("punch")
		get_node("Area2D/CollisionShape2D").disabled = true
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

func _movement(delta:float) -> void:
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move left", "move right")
	if direction:
		velocity.x = direction * SPEED 
		$Animantis.play("walk")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		$Animantis.play("idle")
	move_and_slide()

func Take_Damage(Damage: int):
	Health -= Damage
	
	if Health <= 0: Health = 0
	#healthbar.change_health(-Damage)

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body == get_tree().get_first_node_in_group("Player"):
		var knockback_direction = (body.global_position - global_position).normalized()
		body.apply_knockback(knockback_direction, 5.0, 1.0)
		body.Take_Damage(1)
		
	if body == get_tree().get_first_node_in_group("enemy"):
		var knockback_direction = (body.global_position - global_position).normalized()
		body.apply_knockback(knockback_direction, 5.0, 1.0)
		body.Take_Damage(1)



#play(idle) 
