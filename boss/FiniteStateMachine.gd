extends Node2D
class_name FiniteStateMachine

var current_state: State
var previous_state: State

func _ready():
	current_state = get_child(0) as State
	previous_state = current_state
	current_state.enter()
	pass # Replace with func

func change_state(state):
	current_state = find_child(state) as State
	current_state.enter()
	
	previous_state.exit()
	previous_state = current_state

# Called when the node enters the scene tree for the first time.

