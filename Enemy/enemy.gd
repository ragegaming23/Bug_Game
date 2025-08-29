extends CharacterBody2D
@onready var terget = get_tree().get_first_node_in_group("Player")
const Name = "enemy"
var speed = 200

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	var direction=(terget.position-position).normalized()
	velocity=direction * speed
	look_at(terget.position)
	move_and_slide()
