extends Control


var row = preload("res://row.tscn")
@onready var table = get_node("VBoxContainer/PanelContainer2/ScrollContainer/VBoxContainer")
var sn = 0
var i = 0
var data=[{
	"id":"110",
	"name":"Hello Hi",
	"cls":"8",
	"rollno":"20"
},
{
	"id":"110",
	"name":"Hello Hi",
	"cls":"8",
	"rollno":"20"
},
{
	"id":"110",
	"name":"Hello Hi",
	"cls":"8",
	"rollno":"20"
}]
var nome = "carlos"
var database : SQLite

func set_data(nome):
	sn =sn+1
	
	var instance = row.instantiate()
	instance.name=str(sn)
	table.add_child(instance)
	#instance.connect("pressed", self, "_on_button_pressed")
	
	#get_node("VBoxContainer/PanelContainer2/ScrollContainer/VBoxContainer/"+instance.name+"/1").text=data.id
	#get_node("VBoxContainer/PanelContainer2/ScrollContainer/VBoxContainer/"+instance.name+"/2").text=data.name
	#get_node("VBoxContainer/PanelContainer2/ScrollContainer/VBoxContainer/"+instance.name+"/3").text=data.cls
	get_node("VBoxContainer/PanelContainer2/ScrollContainer/VBoxContainer/"+instance.name+"/4").text=nome
	pass
# Called when the node enters the scene tree for the first time.
func _ready():
	#for i in range(0,data.size()):
		#set_data("antonio")
	
	database = SQLite.new()
	database.path="res://data.db"
	database.open_db()
	
	var rows = database.select_rows("aplicativo", "id >= 0", ["*"])
	var info_text = ""
	for row in rows:
			#info_text = "" + str(row["id"]) + ",  " + row["nome"] +  ",  " + str(row["ba"]) + "\n"
			info_text = "" + row["nome"] + "\n"
			set_data(info_text)
			print(info_text)
	
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
	
	#database.insert_row("aplicativo", data)
	var rows = database.select_rows("aplicativo", "id >= 0", ["*"])
	var info_text = ""
	for row in rows:
			info_text = "" + str(row["id"]) + ",  " + row["nome"] +  ",  " + str(row["ba"]) + "\n"
			print(info_text)
	pass # Replace with function body.



