extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	if Global.activate_e and event.is_action_pressed("interaction_e"):
		%Control.visible = true #Caso ele carrege no E o PC vai abrir
		
	if Global.activate_e and event.is_action_pressed("ui_cancel"):
		%Control.visible = false #Caso ele carrege no ESC o PC vai fechar


