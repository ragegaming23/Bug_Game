extends CharacterBody2D

@export var player_id: int = 1
@export var max_health: int = 100
@export var move_speed: float = 300.0
@export var jump_force: float = -400.0

@onready var main = get_tree().get_root().get_node(".")
@onready var projectile = preload("res://Fighters/Praying Mantis/Praying Mantis ANTIAIR/mantis_cross.tscn")

var current_health: int
var lives: int = 3

var knockback: Vector2 = Vector2.ZERO
var knockback_timer: float = 0.0

var last_attacker_insect: String = ""

signal health_changed(current, max)
signal lives_changed(lives)
signal died


func _ready():
	current_health = max_health

	emit_signal("health_changed", current_health, max_health)
	emit_signal("lives_changed", lives)


func Take_Damage(dmg: int, attacker_insect: String = ""):
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
	var ui := get_tree().root.get_node_or_null("UI")
	if ui:
		ui.visible = false

	var scene_path := "res://Assets/DeathVideoScenes/DragonflyWins_MantisDies_2025-10-29_16-58-07.tscn"

	if last_attacker_insect == "Mantis":
		scene_path = "res://Assets/DeathVideoScenes/MantisVsMantis_Fatality_PLACEHOLDER.tscn"
	get_tree().change_scene_to_file(scene_path)


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


func MantisCross() -> void:
	var instance = projectile.instantiate()

	instance.direction = rotation
	instance.global_position = $"Area2D/Cross Spawn".global_position
	instance.SpawnRot = rotation
	instance.Zdex = z_index - 1

	main.add_child.call_deferred(instance)

	await instance.ready
	instance.get_node("Area2D/CollisionShape2D").set_disabled(true)
	await get_tree().create_timer(0.1).timeout
	instance.get_node("Area2D/CollisionShape2D").set_disabled(false)


func _movement(_delta: float):
	pass


func _on_area_2d_body_entered(body):
	if not body.has_method("Take_Damage"):
		return

	if body.player_id == player_id:
		return

	var direction = (body.global_position - global_position).normalized()

	if body.has_method("apply_knockback"):
		body.apply_knockback(direction, 200.0, 1.0)
	body.Take_Damage(1, "Mantis")
