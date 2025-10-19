extends Node
class_name State

signal transitioned(new_state_name: StringName)
var stateName: String = "Unnamed State"

func enter() -> void:
	pass
	
func exit() -> void:
	pass
	
func update(_delta: float) -> void:
	pass

func physics_update(_delta: float) -> void:
	pass
