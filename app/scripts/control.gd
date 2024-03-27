extends Control


var row = preload("res://app/scenes/row.tscn")
@onready var table = get_node("VBoxContainer/PanelContainer2/ScrollContainer/VBoxContainer")
var sn = 0

func set_data(nome, ba, turma, curso, datadenascimento):
	sn =sn+1 #aqui cada vez que é chamda esta função adicona +1 para saber quantas linhas ha
	
	var instance = row.instantiate() #Aqui, um objeto instance está sendo criado instanciando um modelo chamado row. 
	instance.name=str(sn) #para saber em qual linha ele clicou
	table.add_child(instance)
	
	get_node("VBoxContainer/PanelContainer2/ScrollContainer/VBoxContainer/"+instance.name+"/1").text=ba
	get_node("VBoxContainer/PanelContainer2/ScrollContainer/VBoxContainer/"+instance.name+"/2").text=nome
	get_node("VBoxContainer/PanelContainer2/ScrollContainer/VBoxContainer/"+instance.name+"/3").text=curso
	get_node("VBoxContainer/PanelContainer2/ScrollContainer/VBoxContainer/"+instance.name+"/4").text=turma
	get_node("VBoxContainer/PanelContainer2/ScrollContainer/VBoxContainer/"+instance.name+"/5").text=datadenascimento
	pass
	
# Called when the node enters the scene tree for the first time.
func _ready():

	Global.all_ba.clear()
	Global.database = SQLite.new()
	Global.database.path="res://data.db" #
	Global.database.open_db() #Abre a pasta de SQL onde sao armazenados os dados
	
	var rows = Global.database.select_rows("aplicativo", "id >= 0", ["*"]) # Seleciona os dados onde o id é igual ou maior a zero
	var info_ba = "" ; var info_nome = ""; var info_turma = ""; var info_curso = ""; var info_datadenascimento = ""
	
	for row in rows: #Corre as linhas da base de dados
			info_nome = "" + row["nome"] #está a ficar = ao nome da linha percorrida
			info_ba = "" + str(row["ba"])
			info_turma = "" + row["turma"]
			info_curso = "" + row["curso"]
			info_datadenascimento = "" + str(row["datadenascimento"])
			Global.all_ba.append({"nome" + str(sn): info_ba}) #está a adicionar à variavel global teste todos os ba da base de dados
			Global.all_nome.append({"nome" + str(sn): info_nome}) #está a adicionar à variavel global nomes todos os nomes da base de dados			
			set_data(info_nome, info_ba, info_curso, info_turma, info_datadenascimento) #está a chamar a funcão set_data e a adioncar os dados à tabela
			#print(info_nome)
	pass # Replace with function body.
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#Se algum destes campos nao estiver preenchido o botao salvar fica indisponivel caso contrario fica disponivel
	if $NomeLineEdit.text != "" && %CursoOptionButton.text != "" && $BaLineEdit.text != "" && $TurmaOptionButton.text != "" && $DataLineEdit.text != "":
		%SalvarButton.disabled = false
	else:
		%SalvarButton.disabled = true
	pass
	
	if(Global.botaoclicado == true):
		sn = 0
		Global.botaoclicado = false
		Global.all_ba.clear()
		clear_table()
		_ready()

	if (Global.activate_editar == true): #Mete a cena editar visivel+
		if(%Editar.visible != true):
			%Editar.visible = true
		
	
func clear_table():
	# Corre sobre as crianças do nó da tabela e remove-as uma por uma
	for child in table.get_children():
		table.remove_child(child)

func _on_criar_button_button_down():
	#Cria uma tabela na base de dados
	var table = {
		"id" : {"data_type":"int", "primary_key": true, "not_null":true, "auto_increment" : true},
		"nome" : {"data_type" : "text"},
		"curso" : {"data_type" : "text"},
		"ba" : {"data_type" : "int"},
		"turma" : {"data_type" : "int"},
		"datadenascimento" : {"data_type" : "int"}
	}
	Global.database.create_table("aplicativo", table)
	pass # Replace with function body.


func _on_salvar_button_button_down():
	var Baa = $BaLineEdit.text
	var SelecionaBa = Global.database.select_rows("aplicativo", "ba >= 0", ["*"])
	var registroExiste = false

	var data = {
		"nome" : $NomeLineEdit.text,
		"curso" : %CursoOptionButton.text,
		"ba" : $BaLineEdit.text,
		"turma" : $TurmaOptionButton.text,
		"datadenascimento" : $DataLineEdit.text
	}
	# Salva na base de dados os dados preenchidos nos campos
	
	
	for row in SelecionaBa:
		# Verifique se o texto inserido está presente na linha atual, se existir nao vai insrir o registo
		if str(row.ba) == Baa:
			registroExiste = true
			$BaExistente.visible = true
			print("ja existe")
	if not registroExiste: #se não existir nenhum ba com esse valor vai inserir na base de dados
		Global.database.insert_row("aplicativo", data)
		Global.botaoclicado = true
		
		for i in range(4): # Faz um for até 3 pq começa no 0
			#se a escolha for 1 que é = a adicionar e se o nome for igual ao da tarefa vai acontecer oq está dentro do if
			if int(Global.tarefa_escolhida[i]) == 1 && Global.tarefa_nome_escolhido[i] == str($NomeLineEdit.text):
				print("tarefa concluida")
				Global.tarefas[i] = "" #Limpa a tarefa realizada do quadro de tarefas
				Global.aparecerTarefa_Realizada()
				break
		
		$NomeLineEdit.text = ""
		%CursoOptionButton.text = ""
		$BaLineEdit.text = ""
		$TurmaOptionButton.text = ""
		$DataLineEdit.text = ""
		
		
	
	

	pass # Replace with function body.

func _on_ba_line_edit_text_changed(new_text):
	
	$BaExistente.visible = false
	pass # Replace with function body.




func _on_button_fechar_pressed():
	Global._move_speed = 150 # volta a dar a velocidade ao personagem
	visible = false
	pass # Replace with function body.
