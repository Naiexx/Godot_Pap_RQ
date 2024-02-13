extends Control


var row = preload("res://row.tscn")
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
	
	Global.database = SQLite.new()
	Global.database.path="res://data.db"
	Global.database.open_db()
	
	var rows = Global.database.select_rows("aplicativo", "id >= 0", ["*"])
	var info_ba = "" ; var info_nome = ""; var info_turma = ""; var info_curso = ""; var info_datadenascimento = ""
	
	for row in rows:
			#info_text = "" + str(row["id"]) + ",  " + row["nome"] +  ",  " + str(row["ba"]) + "\n"
			info_nome = "" + row["nome"]
			info_ba = "" + str(row["ba"])
			info_turma = "" + row["turma"]
			info_curso = "" + row["curso"]
			info_datadenascimento = "" + str(row["datadenascimento"])
			Global.all_ba.append({"nome" + str(sn): info_ba}) #está a adicionar à variavel global teste todos os nomes da base de dados
			set_data(info_nome, info_ba, info_curso, info_turma, info_datadenascimento) #está a chamar a funcão set_data e a adioncar os dados à tabela
			print(info_nome)
			
	pass # Replace with function body.
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $NomeLineEdit.text != "" && %CursoOptionButton.text != "" && $BaLineEdit.text != "" && $TurmaOptionButton.text != "" && $DataLineEdit.text != "":
		%SalvarButton.disabled = false
	else:
		%SalvarButton.disabled = true
	pass
	
	if(Global.botaoclicado == true):
		sn = 0
		Global.botaoclicado = false
		Global.all_ba.clear()
		get_tree().reload_current_scene()

func _on_criar_button_button_down():
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
	var data = {
		"nome" : $NomeLineEdit.text,
		"curso" : %CursoOptionButton.text,
		"ba" : $BaLineEdit.text,
		"turma" : $TurmaOptionButton.text,
		"datadenascimento" : $DataLineEdit.text
	}
	
	Global.database.insert_row("aplicativo", data)
	var rows = Global.database.select_rows("aplicativo", "id >= 0", ["*"])
	var info_text = ""
	
	
	for row in rows:
			info_text = "" + str(row["id"]) + ",  " + row["nome"] +  ",  " + str(row["ba"]) + "\n"
			
			print(info_text)
	Global.botaoclicado = true
	pass # Replace with function body.



