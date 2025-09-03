extends CharacterBody2D
@onready var terget = get_tree().get_first_node_in_group("Player")
const Name = "enemy"
var speed = 200

var Knockback: Vector2 = Vector2.ZERO
var Knockback_timer: float = 0.0

func apply_knockback(direction: Vector2, force: float, knockback_duration: float) -> void:
	Knockback = direction * force
	Knockback_timer = knockback_duration
	CanvasModulate
	Color(2,2,2,2)
	Color(1,1,1,1)
	Color(2,2,2,2)
	Color(1,1,1,1)

func _physics_process(delta: float) -> void:
	
	if Knockback_timer > 0.0:
		velocity = Knockback
		Knockback_timer -= delta
		if Knockback_timer <= 0.0:
			Knockback = Vector2.ZERO
	move_and_slide()
	
	if not is_on_floor():
		velocity += get_gravity() * delta
	var direction=(terget.position-position).normalized()
	velocity=direction * speed
	look_at(terget.position)
	move_and_slide()


#func _on_area_2d_body_entered(body: Node2D) -> void:
	# if body == get_tree().get_first_node_in_group("Player"):
		#var knockback_direction = (body.global_position - global_position).normalized()
		#body.apply_knockback(knockback_direction, 150.0, 0.12)
