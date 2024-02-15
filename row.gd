extends HBoxContainer

var a = int(str(self.get_name()))#pega o numero da linna que ele clicou

# Called when the node enters the scene tree for the first time.
func _ready():

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	
	
	a = Global.a - 1 #temos que colocar menos um porque um array começa com 0
	Global.database.delete_rows("aplicativo", "ba = '" + str(Global.all_ba[a]["nome" + str(a)])+ "'")
	
	Global.botaoclicado = true
	print(Global.all_ba[a]["nome" + str(a)])#está a printar o ba que ele selecionou


func _on_button_2_pressed():
	var rows = Global.database.select_rows("aplicativo", "ba = '" + str(Global.all_ba[a]["nome" + str(a)])+ "'", ["*"])

	for row in rows: #Corre as linhas da base de dados
			Global.info_nome2 = "" + row["nome"] #está a ficar = ao nome da linha percorrida
			Global.info_ba2 = "" + str(row["ba"])
			Global.info_turma2 = "" + row["turma"]
			Global.info_curso2 = "" + row["curso"]
			Global.info_datadenascimento2 = "" + str(row["datadenascimento"])
	Global.activate_editar = true
	print(Global.info_ba2)
			 # Seleciona os dados onde o id é igual ou maior a zero
	pass # Replace with function body.
