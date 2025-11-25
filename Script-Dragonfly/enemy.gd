extends CharacterBody2D
#@onready var terget = get_tree().get_first_node_in_group("Player")
#@onready var Healthbar = get_node("/root/Enemy/enemy_health_bar")
var player_id = 2
const Name = "enemy"
var SPEED = 300.0
var JUMP_VELOCITY = -400.0
@onready var main = get_tree().get_root().get_node(".")
@onready var projectile = load("res://Script-Dragonfly/spear_projectile.tscn")


var Lives = 3
var MaxHealth = 20
var Health = 20

@export var max_health: int = 20
var current_health: int = max_health

@onready var HealthBar = $"../HealthBar2"

@onready var lives_ui = $"../P2LivesUI"

@onready var health_textures = [
	preload("res://Assets/Health Bar/New Health bar Mirrored/0.png"),
	preload("res://Assets/Health Bar/New Health bar Mirrored/5.png"),
	preload("res://Assets/Health Bar/New Health bar Mirrored/10.png"),
	preload("res://Assets/Health Bar/New Health bar Mirrored/15.png"),
	preload("res://Assets/Health Bar/New Health bar Mirrored/20.png"),
	preload("res://Assets/Health Bar/New Health bar Mirrored/25.png"),
	preload("res://Assets/Health Bar/New Health bar Mirrored/30.png"),
	preload("res://Assets/Health Bar/New Health bar Mirrored/35.png"),
	preload("res://Assets/Health Bar/New Health bar Mirrored/40.png"),
	preload("res://Assets/Health Bar/New Health bar Mirrored/45.png"),
	preload("res://Assets/Health Bar/New Health bar Mirrored/50.png"),
	preload("res://Assets/Health Bar/New Health bar Mirrored/55.png"),
	preload("res://Assets/Health Bar/New Health bar Mirrored/60.png"),
	preload("res://Assets/Health Bar/New Health bar Mirrored/65.png"),
	preload("res://Assets/Health Bar/New Health bar Mirrored/70.png"),
	preload("res://Assets/Health Bar/New Health bar Mirrored/75.png"),
	preload("res://Assets/Health Bar/New Health bar Mirrored/80.png"),
	preload("res://Assets/Health Bar/New Health bar Mirrored/85.png"),
	preload("res://Assets/Health Bar/New Health bar Mirrored/90.png"),
	preload("res://Assets/Health Bar/New Health bar Mirrored/95.png"),
	preload("res://Assets/Health Bar/New Health bar Mirrored/100.png"),
]

@onready var banner = $"../P2LivesUI/DbannerBLUE"

var banner_textures = {
	3: preload("res://Assets/Health Bar/banners/full health/DbannerBLUE.png"),
	2: preload ("res://Assets/Health Bar/banners/damaged/Dblooban2.png"),
	1: preload ("res://Assets/Health Bar/banners/sappy/DbannerBLUE3.png"),
	0: preload("res://Assets/Health Bar/banners/sappy/DbannerBLUE3.png"),
}
var Knockback: Vector2 = Vector2.ZERO
var Knockback_timer: float = 0.0

func _ready() -> void:
	if player_id == 1:
		add_to_group("Player1")
		print("hi")
	if player_id == 2:
		add_to_group("Player2")
		print("hello")

func apply_knockback(direction: Vector2, force: float, knockback_duration: float) -> void:
	Knockback = direction * force
	Knockback_timer = knockback_duration
	
func Take_Damage(Damage: int):
	current_health = max(current_health - Damage, 0)
	
	# Play Health sound
	if $HealthSFX.playing: # if it’s already playing, restart it
		$HealthSFX.stop()
	$HealthSFX.play()
	
	update_healthbar()
	
	if current_health <= 0:
		Lives -= 1
		current_health = 20
		update_lives_ui()
		
	if Lives <= 0:
		die()
	
func die() -> void:
	get_tree().change_scene_to_file("res://Assets/DeathVideoScenes/Dragonfly_DeathVideo.tscn")

	
func update_lives_ui():
	if lives_ui.has_node("Life1"):
		lives_ui.get_node("Life1").visible = Lives >= 2
	if lives_ui.has_node("Life2"):
		lives_ui.get_node("Life2").visible = Lives >= 3
	if banner:
		if Lives in banner_textures:
			banner.texture = banner_textures[Lives]

func update_healthbar() -> void:
	var health_ratio = float(current_health) / float(max_health)
	var index = int(round(health_ratio * 20))  # 0–20 scale
	index = clamp(index, 0, health_textures.size() - 1)
	HealthBar.texture = health_textures[index]


func _physics_process(delta: float) -> void:
	
	if Knockback_timer > 0.0:
		velocity = Knockback
		Knockback_timer -= delta
		if Knockback_timer <= 0.0:
			Knockback = Vector2.ZERO
	#else:
		#_movement(delta)
	
	
	#if not is_on_floor():
		#velocity += get_gravity() * delta
	#var direction=(terget.position-position).normalized()
	#velocity=direction * speed
	#look_at(terget.position)
	move_and_slide()

#func _movement(_delta:float) -> void:
	#var y_direction := Input.get_axis("move up_%s" %[player_id],"Move down_%s" %[player_id])
	#if y_direction:
		#velocity.y = y_direction * SPEED
		#if !is_punching:
			#$Dragonfly.play("Dragonfly_Flying")
	#else:
		#velocity.y = move_toward(velocity.y, 0, SPEED)
		#if !is_punching:
			#$Dragonfly.play("Dragonfly_Idle")
		
	#if Input.is_action_pressed("punch_%s" %[player_id]) and not is_punching:
		#is_punching = true
		#var animPlayer: AnimatedSprite2D = $Dragonfly
		#animPlayer.play("Dragonfly_New_Jab")
		#get_node("Area2D/CollisionShape2D").disabled = false
		#get_node("Area2D/CollisionShape2D2").disabled = false
		
		#await animPlayer.animation_finished
		#get_node("Area2D/CollisionShape2D").disabled = true
		#get_node("Area2D/CollisionShape2D2").disabled = true
		#is_punching = false
	
	#if Input.is_action_pressed("spear_spin_%s" %[player_id]):
		#$Dragonfly.play("Dragonfly_SpearSpin")
		#get_node("Area2D/CollisionShape2D").disabled = false
		#await get_tree().create_timer(1.0).timeout
		#$Animantis.stop("punch")
		#get_node("Area2D/CollisionShape2D").disabled = true
		
	#if Input.is_action_pressed("spearthrow_%s" %[player_id]):
		#$Dragonfly.play("Dragonfly_SpearThrow")
		#get_node("Area2D/CollisionShape2D").disabled = false
		#await get_tree().create_timer(1.0).timeout
		#$Animantis.stop("punch")
		#get_node("Area2D/CollisionShape2D").disabled = true
		
	#if Input.is_action_pressed("winddust_%s" %[player_id]):
		#$Dragonfly.play("WindDust")
		#get_node("Area2D/CollisionShape2D").disabled = false
		#await get_tree().create_timer(1.0).timeout
		#$Animantis.stop("punch")
		#get_node("Area2D/CollisionShape2D").disabled = true
		
	#if Input.is_action_pressed("block_%s" %[player_id]):
		#$Dragonfly.play("Dragonfly_Block")
		#get_node("Area2D/CollisionShape2D").disabled = false
		#await get_tree().create_timer(1.0).timeout
		#$Animantis.stop("punch")
		#get_node("Area2D/CollisionShape2D").disabled = true
		
	#if Input.is_action_pressed("bicyclekick_%s" %[player_id]):
		#$Dragonfly.play("Dragonfly_BicycleKick")
		#get_node("Area2D/CollisionShape2D").disabled = false
		#await get_tree().create_timer(1.0).timeout
		#$Animantis.stop("punch")
		#get_node("Area2D/CollisionShape2D").disabled = true
		
	#if Input.is_action_just_pressed("jump_%s" %[player_id]) and is_on_floor():
		#$Dragonfly.play("Dragonfly_Flying")
		#velocity.y = JUMP_VELOCITY


	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	#var x_direction := Input.get_axis("move left_%s" %[player_id],"move right_%s" %[player_id])
	#if x_direction !=0:
		#velocity.x = x_direction * SPEED 
		#$Dragonfly.flip_h=x_direction>0
		#$Dragonfly.play("Dragonfly_Flying")
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)
		#$Dragonfly.play("Dragonfly_Idle")
	#move_and_slide()
func Spearthrow():
	var instance = projectile.instantiate()
	instance.direction = rotation
	instance.global_position = $"Area2D/SpearThrow Damage".global_position
	instance.SpawnRot = rotation
	instance.Zdex = z_index -1
	main.add_child.call_deferred(instance)

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		var knockback_direction = (body.global_position - global_position).normalized()
		body.apply_knockback(knockback_direction, 5.0, 1.0)
		body.Take_Damage(1)
