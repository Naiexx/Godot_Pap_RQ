extends Control

var database : SQLite
# Called when the node enters the scene tree for the first time.
func _ready():

		
	database = SQLite.new()
	database.path="res://data.db"
	database.open_db()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $NomeLineEdit.text != "" && %CursoOptionButton.text != "" && $BaLineEdit.text != "" && $TurmaOptionButton.text != "" && $DataLineEdit.text != "":
		%SalvarButton.disabled = false
	else:
		%SalvarButton.disabled = true
	pass


func _on_criar_button_button_down():
	var table = {
		"id" : {"data_type":"int", "primary_key": true, "not_null":true, "auto_increment" : true},
		"nome" : {"data_type" : "text"},
		"curso" : {"data_type" : "text"},
		"ba" : {"data_type" : "int"},
		"turma" : {"data_type" : "int"},
		"datadenascimento" : {"data_type" : "int"}
	}
	database.create_table("aplicativo", table)
	pass # Replace with function body.


func _on_salvar_button_button_down():
	var data = {
		"nome" : $NomeLineEdit.text,
		"curso" : %CursoOptionButton.text,
		"ba" : $BaLineEdit.text,
		"turma" : $TurmaOptionButton.text,
		"datadenascimento" : $DataLineEdit.text
	}
	
	database.insert_row("aplicativo", data)
	var rows = database.select_rows("aplicativo", "id >= 0", ["*"])
	var info_text = ""
	for row in rows:
			info_text = "" + str(row["id"]) + ",  " + row["nome"] +  ",  " + str(row["ba"]) + "\n"
			print(info_text)
	pass # Replace with function body.



