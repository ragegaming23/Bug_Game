extends CharacterBody2D

@export var player_id: int = 1
@export var max_health: int = 100
@export var move_speed: float = 300.0
@export var jump_force: float = -400.0

var current_health: int
var lives: int = 3

var knockback: Vector2 = Vector2.ZERO
var knockback_timer: float = 0.0

signal health_changed(current, max)
signal lives_changed(lives)
signal died

func _ready():
	current_health = max_health
	
	if player_id == 1:
		add_to_group("player_1")
		print("Added to player_1 group")

	elif player_id == 2:
		add_to_group("player_2")
		print("Added to player_2 group")

	# Fire starting values for UI
	emit_signal("health_changed", current_health, max_health)
	emit_signal("lives_changed", lives)


func take_damage(dmg: int):
	current_health = max(current_health - dmg, 0)

	if has_node("HealthSFX"):
		$HealthSFX.play()

	emit_signal("health_changed", current_health, max_health)

	if current_health <= 0:
		lose_life()


func lose_life():
	lives -= 1
	emit_signal("lives_changed", lives)

	if has_node("Animantis"):
		$Animantis.play("death")

	if lives > 0:
		current_health = max_health
		emit_signal("health_changed", current_health, max_health)
	else:
		die()


func die():
	emit_signal("died")

	if player_id == 1:
		get_tree().change_scene_to_file("res://Assets/DeathVideoScenes/Mantis_DeathVideo.tscn")
	else:
		get_tree().change_scene_to_file("res://Assets/DeathVideoScenes/Dragonfly_DeathVideo.tscn")

func apply_knockback(direction: Vector2, force: float, duration: float):
	knockback = direction * force
	knockback_timer = duration

	if has_node("Animantis"):
		$Animantis.play("flinch")


func _physics_process(delta):
	if knockback_timer > 0:
		velocity = knockback
		knockback_timer -= delta
	else:
		_movement(delta)

	move_and_slide()


func _movement(_delta: float):
	pass


func _on_area_2d_body_entered(body):
	if body.is_in_group("enemy") or body.is_in_group("player"):
		var direction = (body.global_position - global_position).normalized()

		if body.has_method("apply_knockback"):
			body.apply_knockback(direction, 200.0, 1.0)

		if body.has_method("take_damage"):
			body.take_damage(1)
