extends CharacterBody2D
@onready var terget=$"."
const Name = "enemy"
var speed = 200

func _physics_process(_delta):
	var direction=(terget.position-position).normalized()
	velocity=direction * speed
	look_at(terget.position)
	move_and_slide()
	
