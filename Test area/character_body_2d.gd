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

@onready var lives_ui = $"../P1LivesUI"

@onready var health_textures = [
	preload("res://Assets/Health Bar/New Health Bar/0.png"),
	preload("res://Assets/Health Bar/New Health Bar/5.png"),
	preload("res://Assets/Health Bar/New Health Bar/10.png"),
	preload("res://Assets/Health Bar/New Health Bar/15.png"),
	preload("res://Assets/Health Bar/New Health Bar/20.png"),
	preload("res://Assets/Health Bar/New Health Bar/25.png"),
	preload("res://Assets/Health Bar/New Health Bar/30.png"),
	preload("res://Assets/Health Bar/New Health Bar/35.png"),
	preload("res://Assets/Health Bar/New Health Bar/40.png"),
	preload("res://Assets/Health Bar/New Health Bar/45.png"),
	preload("res://Assets/Health Bar/New Health Bar/50.png"),
	preload("res://Assets/Health Bar/New Health Bar/55.png"),
	preload("res://Assets/Health Bar/New Health Bar/60.png"),
	preload("res://Assets/Health Bar/New Health Bar/65.png"),
	preload("res://Assets/Health Bar/New Health Bar/70.png"),
	preload("res://Assets/Health Bar/New Health Bar/75.png"),
	preload("res://Assets/Health Bar/New Health Bar/80.png"),
	preload("res://Assets/Health Bar/New Health Bar/85.png"),
	preload("res://Assets/Health Bar/New Health Bar/90.png"),
	preload("res://Assets/Health Bar/New Health Bar/95.png"),
	preload("res://Assets/Health Bar/New Health Bar/100.png"),
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
	#if not is_on_floor():
		#velocity += get_gravity() * delta

func _movement(_delta:float) -> void:
	pass

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
		update_lives_ui()
		
	if Lives <= 0:
		die()

func update_lives_ui():
	# Lives = 3 → show 2 icons
	# Lives = 2 → show 1 icon
	# Lives = 1 → show 0 icons (but still alive)
	# Lives = 0 → dead
	if lives_ui.has_node("Life1"):
		lives_ui.get_node("Life1").visible = Lives >= 2
	if lives_ui.has_node("Life2"):
		lives_ui.get_node("Life2").visible = Lives >= 3

func die()-> void:
	
	get_tree().change_scene_to_file("res://UI/win screen2.tscn")

func update_healthbar() -> void:
	var health_ratio = float(current_health) / float(max_health)
	var index = int(round(health_ratio * 20))  # 21 total textures
	index = clamp(index, 0, health_textures.size() - 1)
	HealthBar.texture = health_textures[index]

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body == get_tree().get_first_node_in_group("enemy"):
		var knockback_direction = (body.global_position - global_position).normalized()
		body.apply_knockback(knockback_direction, 50.0, 1.0)
		body.Take_Damage(1)
		if $".": return
	else:
		if body == get_tree().get_first_node_in_group("player"):
			var knockback_direction = (body.global_position - global_position).normalized()
			body.apply_knockback(knockback_direction, 200.0, 1.0)
			body.Take_Damage(1)


#play(idle) 
