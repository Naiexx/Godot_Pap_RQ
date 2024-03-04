extends Node2D
class_name State

@onready var debug = owner.find_child("debug")
@onready var Character = owner.get_parent().find_child("Character")
@onready var progress_bar = owner.find_child("ProgressBar")
@onready var animaton_player = owner.find_child("AnimationPlayer")



# Called when the node enters the scene tree for the first time.
func _ready():
	set_physics_process(false)
	pass # Replace with function body.
func enter():
	set_physics_process(true)

func exit():
	set_physics_process(false)
	
func transition():
	pass
func _physics_process(_delta):
	transition()
# Called every frame. 'delta' is the elapsed time since the previous frame.
