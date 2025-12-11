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

# NEW: remember what insect last hit this Dragonfly
var last_attacker_insect: String = ""

signal health_changed(current, max)
signal lives_changed(lives)
signal died


func _ready() -> void:
	current_health = max_health

	emit_signal("health_changed", current_health, max_health)
	emit_signal("lives_changed", lives)


# CHANGED: now takes optional attacker_insect
func Take_Damage(dmg: int, attacker_insect: String = "") -> void:
	if attacker_insect != "":
		last_attacker_insect = attacker_insect

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
	
	# Hide UI when a round ends
	var ui := get_tree().root.get_node_or_null("UI")
	if ui:
		ui.visible = false

	# DEFAULT death scene
	var scene_path := "res://Assets/DeathVideoScenes/MantisFatality_DragonflyDies_Update2.tscn"

	# SPECIAL CASES based on who killed Dragonfly:
	#   "Mantis Fatality Update 2"   -> Mantis wins vs Dragonfly
	#   "Dragonfly_Attacker_New0000-0210" -> Dragonfly wins vs Dragonfly
	match last_attacker_insect:
		"Mantis":
			scene_path = "res://Assets/DeathVideoScenes/MantisFatality_DragonflyDies_Update2.tscn"
		"Dragonfly":
			scene_path = "res://Assets/DeathVideoScenes/DragonflyAttacker_New0000-0210.tscn"
		_:
			# keep default Dragonfly_DeathVideo
			pass

	get_tree().change_scene_to_file(scene_path)


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
	# Must be damageable
	if not body.has_method("Take_Damage"):
		return

	# Don't hit yourself
	if body == self:
		return

	# Avoid friendly fire by player_id, same as Mantis
	if body.player_id == player_id:
		return

	var direction = (body.global_position - global_position).normalized()

	if body.has_method("apply_knockback"):
		body.apply_knockback(direction, 200.0, 1.0)

	# IMPORTANT: tell the victim that a DRAGONFLY hit them
	body.Take_Damage(1, "Dragonfly")
