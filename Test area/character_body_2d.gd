extends CharacterBody2D 

@export var player_id = 1
#@onready var healthbar = get_node("res://Health Bar/health_bar.tscn")
@export var  Lives = 3
const Name = "player"
@export var SPEED = 300.0
@export var JUMP_VELOCITY = -400.0

var MaxHealth = 10
var Health = 10

@export var max_health: int = 10
var current_health: int = max_health

@onready var HealthBar = $"../HealthBar1"

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

func _enter_tree() -> void:
	set_multiplayer_authority(name.to_int())

func apply_knockback(knockbackDirection: Vector2, force: float, knockback_duration: float) -> void:
	Knockback = knockbackDirection * force
	Knockback_timer = knockback_duration
	if $".": return
	$Animantis.play("flinch")


func _physics_process(delta: float) -> void:
	#if !is_multiplayer_authority(): return
	
	if Knockback_timer > 0.0:
		velocity = Knockback
		Knockback_timer -= delta
		if Knockback_timer <= 0.0:
			Knockback = Vector2.ZERO
	else:
		_movement(delta)
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

func _movement(_delta:float) -> void:
	if Input.is_action_pressed("punch_%s" %[player_id]):
		$Animantis.play("punch")
		get_node("Area2D/CollisionShape2D").disabled = false
		await get_tree().create_timer(1.0).timeout
		#$Animantis.stop("punch")
		get_node("Area2D/CollisionShape2D").disabled = true
		
	if Input.is_action_just_pressed("jump_%s" %[player_id]) and is_on_floor():
		$Animantis.play("jump")
		velocity.y = JUMP_VELOCITY
		get_node("Area2D/CollisionShape2D").disabled = false
		await get_tree().create_timer(1.0).timeout
		#$Animantis.stop("jump")
		get_node("Area2D/CollisionShape2D").disabled = true
		
	if Input.is_action_pressed("slash_%s" %[player_id]):
		$Animantis.play("slash")
		get_node("Area2D/CollisionShape2D").disabled = false
		await get_tree().create_timer(1.0).timeout
		#$Animantis.stop("slash")
		get_node("Area2D/CollisionShape2D").disabled = true
		
	if Input.is_action_pressed("multislash_%s" %[player_id]):
		$Animantis.play("multislash")
		get_node("Area2D/CollisionShape2D").disabled = false
		await get_tree().create_timer(1.0).timeout
		#$Animantis.stop("multislash")
		get_node("Area2D/CollisionShape2D").disabled = true
		
	if Input.is_action_pressed("headbut_%s" %[player_id]):
		$Animantis.play("headbut")
		get_node("Area2D/CollisionShape2D").disabled = false
		await get_tree().create_timer(1.0).timeout
		#$Animantis.stop("headbut")
		get_node("Area2D/CollisionShape2D").disabled = true
		
	if Input.is_action_pressed("block_%s" %[player_id]):
		$Animantis.play("block")
		get_node("Area2D/CollisionShape2D").disabled = false
		await get_tree().create_timer(1.0).timeout
		#$Animantis.stop("block")
		get_node("Area2D/CollisionShape2D").disabled = true

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move left_%s" %[player_id], "move right_%s" %[player_id])
	if direction !=0:
		velocity.x = direction * SPEED 
		$Animantis.flip_h=direction <0
		$Animantis.play("walk")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		$Animantis.play("idle")
	move_and_slide()

func Take_Damage(Damage: int):
	current_health = max(current_health - Damage, 0)
	
	# Play damage sound
	if $HealthSFX.playing: # if it’s already playing, restart it
		$HealthSFX.stop()
	$HealthSFX.play()
	
		# Play Hit sound
	if $HitSFX.playing:
		$HitSFX.stop()
	$HitSFX.play()
	
	update_healthbar()
	
	if current_health <= 0:
		Lives -= 1
		current_health = 10
		
	if Lives <= 0:
		die()

func die()-> void:
	get_tree().change_scene_to_file("res://UI/win screen2.tscn")

func update_healthbar() -> void:
	# Calculate which image index to use (0–10)
	var health_ratio = float(current_health) / float(max_health)
	var index = int(round(health_ratio * 10))  # 0–10 scale
	HealthBar.texture = health_textures[index]
	
func _on_area_2d_body_entered(body: Node2D) -> void:
	
	if body == get_tree().get_first_node_in_group("enemy"):
		var knockback_direction = (body.global_position - global_position).normalized()
		body.apply_knockback(knockback_direction, 2.0, 1.0)
		body.Take_Damage(1)
		if $".": return
	else:
		if body == get_tree().get_first_node_in_group("player"):
			var knockback_direction = (body.global_position - global_position).normalized()
			body.apply_knockback(knockback_direction, 200.0, 1.0)
			body.Take_Damage(1)


#play(idle) 
