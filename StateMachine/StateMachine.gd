class_name StateMachine
extends Node

@export var initial_state : State
@export var currentState: State
@export var startOnReady: bool = true

var states: Dictionary = {}

func _ready() -> void:
	if startOnReady:
		start()

func start() -> void:
	for child in get_children():
		if child is State:
			states[child.name] = child
			child.transitioned.connect(on_child_transitioned)
		else:
			push_warning("State machine contains child which is not 'State'")
	if initial_state:
		initial_state.enter()
		currentState = initial_state
	currentState.enter()
	
func _process(delta) -> void:
	currentState.update(delta)
		
func _physics_process(delta) -> void:
	currentState.physics_update(delta)
	
func on_child_transitioned(newStateName: StringName) -> void:
	var newState = states.get(newStateName)
	if newState != null:
		if newState != currentState:
			currentState.exit()
			newState.enter()
			currentState = newState
	else:
		push_warning("Called transition on a state that does not exist")

func add_state(stateName):
	states[stateName] = states.size()
