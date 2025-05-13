extends Node
class_name StateMachine

@export var initial_state: State

var states: Dictionary = {}
var current_state: State

func _ready():
	assert(initial_state != null, "initial state is null")
	var children = get_children()
	assert(len(children) > 0, "no child states found")
	
	for state in children:
		if state is State:
			states[state.name.to_lower()] = state
			state.transitioned.connect(on_state_transitioned)

	assert(states.has(initial_state.name.to_lower()), "initial_state is not a valid child State")
	
	initial_state.enter()
	current_state = initial_state


func _process(delta: float) -> void:
	if not current_state: return
	current_state.update(delta)

func _physics_process(delta: float) -> void:
	if not current_state: return
	current_state.physics_update(delta)


func on_state_transitioned(state: State, new_state_name: String):
	if state != current_state: return
	
	var new_state = states.get(new_state_name.to_lower())
	assert(new_state != null, "new state does not exist")
	
	current_state.exit()
	
	new_state.enter()
	current_state = new_state
