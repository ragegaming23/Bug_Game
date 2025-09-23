extends CharacterBody2D
#@onready var terget = get_tree().get_first_node_in_group("Player")
#@onready var Healthbar = get_node("/root/Enemy/enemy_health_bar")
var player_id = 2
const Name = "enemy"
const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var MaxHealth = 10
var Health = 10

@export var max_health: int = 10
var current_health: int = max_health

@onready var HealthBar = $"../HealthBar2"

@onready var health_textures = [
	preload("res://Health Bar/Leaf Health Progression/Health_0.png"),
	preload("res://Health Bar/Leaf Health Progression/Health_1.png"),
	preload("res://Health Bar/Leaf Health Progression/Health_2.png"),
	preload("res://Health Bar/Leaf Health Progression/Health_3.png"),
	preload("res://Health Bar/Leaf Health Progression/Health_4.png"),
	preload("res://Health Bar/Leaf Health Progression/Health_5.png"),
	preload("res://Health Bar/Leaf Health Progression/Health_6.png"),
	preload("res://Health Bar/Leaf Health Progression/Health_7.png"),
	preload("res://Health Bar/Leaf Health Progression/Health_8.png"),
	preload("res://Health Bar/Leaf Health Progression/Health_9.png"),
	preload("res://Health Bar/Leaf Health Progression/Health_10.png"),
]

var Knockback: Vector2 = Vector2.ZERO
var Knockback_timer: float = 0.0

func apply_knockback(direction: Vector2, force: float, knockback_duration: float) -> void:
	Knockback = direction * force
	Knockback_timer = knockback_duration
	

func Take_Damage(Damage: int):
	current_health = max(current_health - Damage, 0)
	update_healthbar()
	if current_health <= 0:
		die()

func die()-> void:
	get_tree().change_scene_to_file("res://UI/win_screen.gd")

func update_healthbar() -> void:
	# Calculate which image index to use (0–10)
	var health_ratio = float(current_health) / float(max_health)
	var index = int(round(health_ratio * 10))  # 0–10 scale
	HealthBar.texture = health_textures[index]


func _physics_process(delta: float) -> void:
	
	if Knockback_timer > 0.0:
		velocity = Knockback
		Knockback_timer -= delta
		if Knockback_timer <= 0.0:
			Knockback = Vector2.ZERO
	else:
		_movement(delta)
	#if Input.is_action_pressed("punch_%s" %[player_id]):
		#$Dragonfly.play("jab")
		#get_node("Area2D/CollisionShape2D").disabled = false
		#get_node("Area2D/CollisionShape2D2").disabled = false
		#await get_tree().create_timer(1.0).timeout
		#$Dragonfly.stop("jab")
		#get_node("Area2D/CollisionShape2D").disabled = true
		#get_node("Area2D/CollisionShape2D2").disabled = true
	
	if not is_on_floor():
		velocity += get_gravity() * delta
	#var direction=(terget.position-position).normalized()
	#velocity=direction * speed
	#look_at(terget.position)
	move_and_slide()
func _movement(_delta:float) -> void:
	if Input.is_action_pressed("punch_%s" %[player_id]):
		$Dragonfly.play("jab")
		get_node("Area2D/CollisionShape2D").disabled = false
		get_node("Area2D/CollisionShape2D2").disabled = false
		await get_tree().create_timer(1.0).timeout
		#$Dragonfly.stop("jab")
		get_node("Area2D/CollisionShape2D").disabled = true
		get_node("Area2D/CollisionShape2D2").disabled = true
	
	if Input.is_action_just_pressed("jump_%s" %[player_id]) and is_on_floor():
		$Dragonfly.play("flying")
		velocity.y = JUMP_VELOCITY
		

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move left_%s" %[player_id], "move right_%s" %[player_id])
	if direction:
		velocity.x = direction * SPEED 
		$Dragonfly.play("flying")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		$Dragonfly.play("idle")
	move_and_slide()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body == get_tree().get_first_node_in_group("Player"):
		var knockback_direction = (body.global_position - global_position).normalized()
		body.apply_knockback(knockback_direction, 5.0, 1.0)
		body.Take_Damage(1)
