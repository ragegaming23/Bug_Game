extends CharacterBody2D
#@onready var terget = get_tree().get_first_node_in_group("Player")
#@onready var Healthbar = get_node("/root/Enemy/enemy_health_bar")
var player_id = 2
const Name = "enemy"
const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var Lives = 3
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
	
	# Play damage sound
	if $DamageSFX.playing: # if it’s already playing, restart it
		$DamageSFX.stop()
	$DamageSFX.play()
	
	update_healthbar()
	
	if current_health <= 0:
		Lives -= 1
		current_health = 10
		
	if Lives <= 0:
		die()
	
func die()-> void:
	get_tree().change_scene_to_file("res://UI/win screen.tscn")

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
	
	
	#if not is_on_floor():
		#velocity += get_gravity() * delta
	#var direction=(terget.position-position).normalized()
	#velocity=direction * speed
	#look_at(terget.position)
	move_and_slide()
var is_punching = false
func _movement(_delta:float) -> void:
	var y_direction := Input.get_axis("move up_%s" %[player_id],"Move down_%s" %[player_id])
	if y_direction:
		velocity.y = y_direction * SPEED
		if !is_punching:
			$Dragonfly.play("Dragonfly_Flying")
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
		if !is_punching:
			$Dragonfly.play("Dragonfly_Idle")
		
	if Input.is_action_pressed("punch_%s" %[player_id]) and not is_punching:
		is_punching = true
		var animPlayer: AnimatedSprite2D = $Dragonfly
		animPlayer.play("Dragonfly_New_Jab")
		get_node("Area2D/CollisionShape2D").disabled = false
		get_node("Area2D/CollisionShape2D2").disabled = false
		
		await animPlayer.animation_finished
		get_node("Area2D/CollisionShape2D").disabled = true
		get_node("Area2D/CollisionShape2D2").disabled = true
		is_punching = false
	
	if Input.is_action_pressed("spear_spin_%s" %[player_id]):
		$Dragonfly.play("Dragonfly_SpearSpin")
		get_node("Area2D/CollisionShape2D").disabled = false
		await get_tree().create_timer(1.0).timeout
		#$Animantis.stop("punch")
		get_node("Area2D/CollisionShape2D").disabled = true
		
	if Input.is_action_pressed("spearthrow_%s" %[player_id]):
		$Dragonfly.play("Dragonfly_SpearThrow")
		get_node("Area2D/CollisionShape2D").disabled = false
		await get_tree().create_timer(1.0).timeout
		#$Animantis.stop("punch")
		get_node("Area2D/CollisionShape2D").disabled = true
		
	if Input.is_action_pressed("winddust_%s" %[player_id]):
		$Dragonfly.play("WindDust")
		get_node("Area2D/CollisionShape2D").disabled = false
		await get_tree().create_timer(1.0).timeout
		#$Animantis.stop("punch")
		get_node("Area2D/CollisionShape2D").disabled = true
		
	if Input.is_action_pressed("block_%s" %[player_id]):
		$Dragonfly.play("Dragonfly_Block")
		get_node("Area2D/CollisionShape2D").disabled = false
		await get_tree().create_timer(1.0).timeout
		#$Animantis.stop("punch")
		get_node("Area2D/CollisionShape2D").disabled = true
		
	if Input.is_action_pressed("bicyclekick_%s" %[player_id]):
		$Dragonfly.play("Dragonfly_BicycleKick")
		get_node("Area2D/CollisionShape2D").disabled = false
		await get_tree().create_timer(1.0).timeout
		#$Animantis.stop("punch")
		get_node("Area2D/CollisionShape2D").disabled = true
		
	if Input.is_action_just_pressed("jump_%s" %[player_id]) and is_on_floor():
		$Dragonfly.play("Dragonfly_Flying")
		velocity.y = JUMP_VELOCITY


	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var x_direction := Input.get_axis("move left_%s" %[player_id],"move right_%s" %[player_id])
	if x_direction:
		velocity.x = x_direction * SPEED 
		$Dragonfly.play("Dragonfly_Flying")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		$Dragonfly.play("Dragonfly_Idle")
	move_and_slide()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body == get_tree().get_first_node_in_group("Player"):
		var knockback_direction = (body.global_position - global_position).normalized()
		body.apply_knockback(knockback_direction, 5.0, 1.0)
		body.Take_Damage(1)
