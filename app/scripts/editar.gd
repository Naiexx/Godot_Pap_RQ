extends Control

var add = false
var badomesmo = ""
var cursodomemso = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Global.activate_editar == true && add == false:
		$BaLineEdit2.text= Global.info_ba2
		$NomeLineEdit2.text = Global.info_nome2
		$DataLineEdit2.text = Global.info_datadenascimento2
		%TurmaOptionButt2on.text = Global.info_turma2
		%CurosOptionButton2.text = Global.info_curso2
		badomesmo = Global.info_ba2 #para guardar o ba que ele ja tinha antes de começar a editar
		cursodomemso = Global.info_curso2 #para guardar o curso que ele ja tinha antes de começar a editar
		add = true
	pass


func _on_atualizar_button_pressed():
	var Baa = $BaLineEdit2.text
	var SelecionaBa = Global.database.select_rows("aplicativo", "ba >= 0", ["*"])
	var registroExiste = false
	
	for row in SelecionaBa:
		# Verifique se o texto inserido está presente na linha atual, se existir nao vai insrir o registo
		if str(row.ba) == Baa && str(badomesmo) != $BaLineEdit2.text: #
			registroExiste = true
			$BaExistente.visible = true
			print("ja existe")
	if not registroExiste: #se não existir nenhum ba com esse valor edita os campos
		Global.database.update_rows("aplicativo", "nome = '" + Global.info_nome2 + "'", {"nome": (%NomeLineEdit2.text) })
		Global.database.update_rows("aplicativo", "ba = '" + Global.info_ba2 + "'", {"ba": (%BaLineEdit2.text) })
		Global.database.update_rows("aplicativo", "datadenascimento = '" + Global.info_datadenascimento2 + "'", {"datadenascimento": (%DataLineEdit2.text) })
		Global.database.update_rows("aplicativo", "curso = '" + Global.info_curso2 + "'", {"curso": (%CurosOptionButton2.text) })
		Global.database.update_rows("aplicativo", "turma = '" + Global.info_turma2 + "'", {"turma": (%TurmaOptionButt2on.text) })
		Global.activate_editar = false
		visible = false
		Global.botaoclicado = true
		add = false
		
		for i in range(4): # Faz um for até 3 pq começa no 0
		#se a escolha for 3 que é = a editar e se o ba da tarefa for o mesmo do ba que ele está a editar e se ele tiver atualizado o curso vai acontecer oq está dentro do if
			if int(Global.tarefa_escolhida[i]) == 3 && Global.tarefa_nome_escolhido[i] == badomesmo && %CurosOptionButton2.text != cursodomemso:
				print("tarefa concluida")
				Global.tarefas[i] = "" #Limpa a tarefa realizada do quadro de tarefas
				break
		
	pass # Replace with function body.
	
func _input(event):
	if Global.activate_editar == true and event.is_action_pressed("ui_cancel"):
		Global.activate_editar = false
		add = false
		visible = false #Caso ele carrege no ESC o PC vai fechar


func _on_fechar_button_pressed():
	Global.activate_editar = false
	add = false
	visible = false
	$BaExistente.visible = false	
	pass # Replace with function body.


func _on_ba_line_edit_2_text_changed(new_text):
	$BaExistente.visible = false
	pass # Replace with function body.
