extends Node

var vidaplayer = 10

var vidaboss = 10

var database : SQLite

var botaoclicado = false

var activate_e = false

var activate_e2 = false

var _move_speed: float = 150.0

var all_ba = [ ]

var all_nome = []


var activate_editar = false

var info_ba2 = "" ; var info_nome2 = ""; var info_turma2 = ""; var info_curso2 = ""; var info_datadenascimento2 = ""

var perguntas = [
	"Qual é a capital do Brasil?",
	"Quem escreveu 'Dom Quixote'?",
	"Quantos planetas existem em nosso sistema solar?"
]

var respostas = [
	"v",
	"v",
	"f"
]

var nomesAleatorios = [
	"Sofia",
	"Maria",
	"Leonor",
	"Matilde",
	"Mariana",
	"Ana",
	"Francisco",
	"Afonso",
	"Martim",
	"João",
	"Pedro",
	"Tiago",
	"Beatriz",
	"Carolina",
	"Inês",
	"Rita",
	"Tomás",
	"Duarte",
	"Diana",
	"Luisa"
]
var tarefas  = [
	"",
	"",
	"",
	""
] 

var pergunta_random = randi() % perguntas.size() #Randomiza a variavel consoante a quantidate de perguntas na varaivel perguntas


func randomizaPergunta():
	pergunta_random = randi() % perguntas.size() #Randomiza a variavel consoante a quantidate de perguntas na varaivel perguntas
	pass
	
func randomizarTarefa():
	var nome_random = randi() % nomesAleatorios.size() #Escolhe um numero random consoante os nomes existentes
	var ba_random = randi() % all_ba.size() #Escolhe um numero random consoante os bas existentes
	
	#print(Global.all_nome[tarefa_random]["nome" + str(tarefa_random)]) #está um nome aleatorio
	var nome = nomesAleatorios[nome_random]# esta a guardar à variavel um nome aleatorio
	var ba = Global.all_ba[ba_random]["nome" + str(ba_random)] # esta a guardar à variavel um ba aleatorio
	var numero_aleatorio = randi_range(1, 3) #randomiza um numero de 1 a 3
	var tarefa = "" 
	var tarefaSelecionada = ""
	var BaIgual = false
	if numero_aleatorio == 1:
		while tarefa == "": # Loop enquanto a variável tarefa for = a ""
			for i in range(4): #Este for vai verificar se o ba aleatorio é igual a algum ba de uma tarefa
				if nome == Global.tarefa_nome_escolhido[i]:
					nome_random = randi() % all_ba.size()
					nome = nomesAleatorios[nome_random]
					BaIgual = true
					print("randomizou")
					#caso seja igual a um ba de uma tarefa vai randomizar outro ba
			if BaIgual == false: #caso nao exista nenhum ba igual adiciona a tarefa
				tarefa = "Adiciona um registo com o nome " + nome + "!"
				print("adicionou tarefaaaaaa")
			BaIgual = false
		tarefa = "Adiciona um registo com o nome " + nome + "!"
		Global.escolhida_tarefa = 1
		Global.nome_tarefa = nome
	if numero_aleatorio == 2:
		while tarefa == "": # Loop enquanto a variável tarefa for = a ""
			for i in range(4): #Este for vai verificar se o ba aleatorio é igual a algum ba de uma tarefa
				if ba == Global.tarefa_nome_escolhido[i]:
					ba_random = randi() % all_ba.size()
					ba = Global.all_ba[ba_random]["nome" + str(ba_random)]
					BaIgual = true
					print("randomizou")
					#caso seja igual a um ba de uma tarefa vai randomizar outro ba
			if BaIgual == false: #caso nao exista nenhum ba igual adiciona a tarefa
				tarefa = "Elimina o registo com o ba " + ba + "!"
				print("adicionou tarefaaaaaa")
			BaIgual = false
		Global.escolhida_tarefa = 2
		Global.nome_tarefa = ba
	if numero_aleatorio == 3:
		while tarefa == "": # Loop enquanto a variável tarefa for = a ""
			for i in range(4): #Este for vai verificar se o ba aleatorio é igual a algum ba de uma tarefa
				if ba == Global.tarefa_nome_escolhido[i]:
					ba_random = randi() % all_ba.size()
					ba = Global.all_ba[ba_random]["nome" + str(ba_random)]
					BaIgual = true
					print("randomizou")
					#caso seja igual a um ba de uma tarefa vai randomizar outro ba
			if BaIgual == false: #caso nao exista nenhum ba igual adiciona a tarefa
				tarefa = "Edita o registo com o ba " + ba + "!"
				print("adicionou tarefaaaaaa")
			BaIgual = false
		Global.escolhida_tarefa = 3
		Global.nome_tarefa = ba
	
	return tarefa #Vai retornar a tarefa randomizada
	pass
	
var nome_tarefa; var escolhida_tarefa
var tarefa_nome_escolhido = ["",
	"",
	"",
	""]
var tarefa_escolhida = ["",
	"",
	"",
	""]
	
func adicionarTarefa():
	
	for i in range(4): # Faz um for até 3 pq começa no 0
		print(i)
		if tarefas[i] == "": # Caso não exista tarefa vai adiciona-la 
			tarefas[i] = randomizarTarefa()
			Global.tarefa_nome_escolhido[i] = Global.nome_tarefa #Guarda à variavel o nome da tarefa adicionado
			Global.tarefa_escolhida[i] = Global.escolhida_tarefa #Guarda à variavel o numero da tarefa adicionado
			break # Dá break ao for
	pass 
	
func carregarCena():
	# Carrega a próxima cena para onde queremos transicionar
	#var cena_transicao = load("res://Parte_da_luta/boss/luta.tscn")  
	# Transição suave de cena
	get_tree().change_scene_to_file("res://Parte_da_luta/boss/luta.tscn")
