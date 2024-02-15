extends Control

var add = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Global.activate_editar == true && add == false:
		$BaLineEdit2.text= Global.info_ba2
		$NomeLineEdit2.text = Global.info_nome2
		$DataLineEdit2.text = Global.info_datadenascimento2
		%TurmaOptionButton.text = Global.info_turma2
		%CurosOptionButton2.text = Global.info_curso2
		add = true
	print("a")
	pass


func _on_atualizar_button_pressed():
	Global.database.update_rows("aplicativo", "nome = '" + Global.info_nome2 + "'", {"nome": (%NomeLineEdit2.text) })
	Global.database.update_rows("aplicativo", "ba = '" + Global.info_ba2 + "'", {"ba": (%BaLineEdit2.text) })
	Global.database.update_rows("aplicativo", "datadenascimento = '" + Global.info_datadenascimento2 + "'", {"datadenascimento": (%DataLineEdit2.text) })
	Global.database.update_rows("aplicativo", "curso = '" + Global.info_curso2 + "'", {"curso": (%CurosOptionButton2.text) })
	Global.database.update_rows("aplicativo", "turma = '" + Global.info_turma2 + "'", {"turma": (%TurmaOptionButton.text) })
	
	Global.botaoclicado = true
	print("a")
	pass # Replace with function body.
	

