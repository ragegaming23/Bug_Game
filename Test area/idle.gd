extends State
class_name Idle

@export var player: CharacterBody2D
@export var SPEED:= 0


func enter() -> void:
	$Animantis.play("idle")

#func _process(delta: float) -> void:
	#if not is_on_floor():
	#velocity += get_gravity() * delta

#func _physics_process(delta) -> void:
	#if not is_on_floor():
	#velocity += get_gravity() * delta
func exit() -> void:
	pass
	
func update(_delta: float) -> void:
	if (Input.get_axis("move left_%s" %[player_id], "move right_%s" %[player_id])):
		
	if Input.is_action_pressed("punch_%s" %[player_id]):
		
	pass

func physics_update(_delta: float) -> void:
	pass
