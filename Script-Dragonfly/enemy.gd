extends CharacterBody2D

@export var player_id: int = 2
@export var max_health: int = 20
@export var move_speed: float = 300.0
@export var jump_force: float = -400.0

const NAME = "Dragonfly"

var current_health: int
var lives: int = 3

@onready var main = get_tree().get_root().get_node(".")
@onready var projectile = preload("res://Script-Dragonfly/spear_projectile.tscn")

var knockback: Vector2 = Vector2.ZERO
var knockback_timer: float = 0.0

signal health_changed(current, max)
signal lives_changed(lives)
signal died


func _ready() -> void:
	current_health = max_health

	if player_id == 1:
		add_to_group("player_1")
		print("Added to player_1 group")

	elif player_id == 2:
		add_to_group("player_2")
		print("Added to player_2 group")

	emit_signal("health_changed", current_health, max_health)
	emit_signal("lives_changed", lives)


func Take_Damage(dmg: int) -> void:
	current_health = max(current_health - dmg, 0)

	if has_node("HealthSFX"):
		if $HealthSFX.playing:
			$HealthSFX.stop()
		$HealthSFX.play()

	emit_signal("health_changed", current_health, max_health)

	if current_health <= 0:
		lose_life()


func lose_life() -> void:
	lives -= 1
	emit_signal("lives_changed", lives)

	if has_node("AnimDragonfly"):
		$AnimDragonfly.play("death")

	if lives > 0:
		current_health = max_health
		emit_signal("health_changed", current_health, max_health)
	else:
		die()


func die() -> void:
	emit_signal("died")

	if player_id == 1:
		get_tree().change_scene_to_file("res://Assets/DeathVideoScenes/Mantis_DeathVideo.tscn")
	else:
		get_tree().change_scene_to_file("res://Assets/DeathVideoScenes/Dragonfly_DeathVideo.tscn")


func apply_knockback(direction: Vector2, force: float, duration: float) -> void:
	knockback = direction * force
	knockback_timer = duration

	if has_node("AnimDragonfly"):
		$AnimDragonfly.play("flinch")

func _physics_process(delta: float) -> void:
	if knockback_timer > 0:
		velocity = knockback
		knockback_timer -= delta

	move_and_slide()


func Spearthrow() -> void:
	var instance = projectile.instantiate()

	instance.direction = rotation
	instance.global_position = $"Area2D/SpearThrow Damage".global_position
	instance.SpawnRot = rotation
	instance.Zdex = z_index - 1

	main.add_child.call_deferred(instance)

	await instance.ready
	instance.get_node("Area2D/CollisionShape2D").set_disabled(true)
	await get_tree().create_timer(0.1).timeout
	instance.get_node("Area2D/CollisionShape2D").set_disabled(false)


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player_1") or body.is_in_group("player_2") or body.is_in_group("enemy"):
		var direction = (body.global_position - global_position).normalized()

		if body.has_method("apply_knockback"):
			body.apply_knockback(direction, 200.0, 1.0)

		if body.has_method("Take_Damage"):
			body.Take_Damage(1)
