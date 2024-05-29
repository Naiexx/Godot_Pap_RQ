extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel") and Global.pause == true:
		visible = true
		get_tree().paused = true

func _on_button_voltar_pressed():
	get_tree().paused = false
	visible = false
	pass # Replace with function body.


func _on_button_sair_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://menu_inicial/scenes/Menu_Inicial.tscn")
	
	visible = false
