extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	%"1".text = Global.tarefas[0]
	%"2".text = Global.tarefas[1]
	%"3".text = Global.tarefas[2]
	%"4".text = Global.tarefas[3]	
	pass

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		Global._move_speed = 150 # volta a dar a velocidade ao personagem
		visible = false #Caso ele carrege no ESC o PC vai fechar
