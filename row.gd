extends HBoxContainer

signal pressed

# Called when the node enters the scene tree for the first time.
func _ready():

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	var a = int(str(self.get_name())) #pega o numero da linna que ele clicou
	
	
	a = a - 1 #temos que colocar menos um porque um array começa com 0
	Global.database.delete_rows("aplicativo", "ba = '" + str(Global.all_ba[a]["nome" + str(a)])+ "'")
	
	Global.botaoclicado = true
	print(Global.all_ba[a]["nome" + str(a)])#está a printar o ba que ele selecionou
