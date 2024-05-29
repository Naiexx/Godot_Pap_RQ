extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	if Global.activate_e and event.is_action_pressed("interaction_e"):
		Global._move_speed = 0 # tira a velocidade do personagem
		%Control.visible = true #Caso ele carrege no E o PC vai abrir
		Global.pause = false
		
		
	if Global.activate_e and event.is_action_pressed("ui_cancel"):
		%Control.visible = false #Caso ele carrege no ESC o PC vai fechar
		Global._move_speed = 150 # volta a dar a velocidade ao personagem		
		var timer : Timer = Timer.new()
		add_child(timer)
		timer.one_shot = true
		timer.autostart = false
		timer.wait_time = 0.1
		timer.timeout.connect(_timer_Timeout)
		timer.start()
		#teste david34


		
		#get_tree().change_scene_to_file("res://character/scenes/node_2d.tscn")
func _timer_Timeout():
	Global.pause = true
	pass
