extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if visible != Global.tarefa_realizada_visible:
		visible = Global.tarefa_realizada_visible
	pass
