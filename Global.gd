extends Node


var contar_morte = true

var seconds = 20
var minutes = 0

var danoRecebido = false
var danoRecebido2 = false

var _player_ref = null

var progressoJogo = 0

var acabar = false

var vidaplayer = 10

var vidaboss = 10

var database : SQLite

var botaoclicado = false

var activate_e = false

var activate_e_quadro = false

var activate_e2 = false

var _move_speed: float = 150.0

var all_ba = [ ]

var all_nome = []

var stats_respostas_certas = 0
var stats_respostas_erradas = 0
var stats_mortes = 0
var stats_tempo = 0
var stats_tarefas_realizadas = 0

var activate_editar = false

var pause = true

var info_ba2 = "" ; var info_nome2 = ""; var info_turma2 = ""; var info_curso2 = ""; var info_datadenascimento2 = ""

var perguntas = [
	"A gestão eficaz depende exclusivamente das habilidades técnicas do gestor?",
	"A comunicação clara é essencial para uma boa gestão de equipes?",
	"A delegação de tarefas é uma prática importante para a eficiência gerencial?",
	"Um bom gestor nunca deve admitir erros na frente da sua equipe?",
	"O feedback constante pode ajudar a melhorar o desempenho dos funcionários?",
	"A gestão de tempo não é relevante para a produtividade?",
	"Estabelecer metas SMART é uma prática comum na gestão de projetos?",
	"A liderança autocrática é sempre a melhor abordagem em todas as situações?",
	"Conhecer bem a equipe pode ajudar a delegar tarefas de forma mais eficiente?",
	"A inovação é um componente crucial na gestão moderna?",
	"A resistência a mudanças é um desafio comum enfrentado pelos gestores?",
	"A análise SWOT é uma ferramenta de gestão que avalia forças, fraquezas, oportunidades e ameaças?",
	"A gestão de conflitos não é necessária em um ambiente de trabalho harmonioso?",
	"O planejamento estratégico é uma responsabilidade dos gestores de nível superior?",
	"Todos os gestores devem ter habilidades de negociação?",
	"A motivação dos funcionários não afeta diretamente a produtividade da empresa?",
	"A gestão de recursos humanos inclui o recrutamento, a seleção e a formação de funcionários?",
	"A tecnologia não tem impacto significativo na gestão de projetos?",
	"O trabalho em equipe pode ser promovido por meio de atividades de team building?",
	"O gestor deve ser um exemplo de comportamento ético para a equipe?",
	"O controle de custos é uma parte essencial da gestão financeira?",
	"A gestão de risco envolve identificar, avaliar e mitigar riscos potenciais?",
	"A comunicação descendente é a única forma de comunicação eficaz em uma empresa?",
	"O treinamento e desenvolvimento contínuo dos funcionários é crucial para a competitividade da empresa?",
	"A tomada de decisão deve sempre ser feita de forma centralizada?",
	"A análise de dados pode ajudar a tomar decisões mais informadas na gestão?",
	"A transparência na gestão aumenta a confiança dos funcionários?",
	"A avaliação de desempenho é uma prática desnecessária em empresas pequenas?",
	"O empowerment dos funcionários pode levar a uma maior satisfação no trabalho?",
	"O gestor deve evitar qualquer forma de inovação para manter a estabilidade da empresa?"
]

var respostas = [
	"f", # A gestão eficaz depende exclusivamente das habilidades técnicas do gestor?
	"v", # A comunicação clara é essencial para uma boa gestão de equipes?
	"v", # A delegação de tarefas é uma prática importante para a eficiência gerencial?
	"f", # Um bom gestor nunca deve admitir erros na frente da sua equipe?
	"v", # O feedback constante pode ajudar a melhorar o desempenho dos funcionários?
	"f", # A gestão de tempo não é relevante para a produtividade?
	"v", # Estabelecer metas SMART é uma prática comum na gestão de projetos?
	"f", # A liderança autocrática é sempre a melhor abordagem em todas as situações?
	"v", # Conhecer bem a equipe pode ajudar a delegar tarefas de forma mais eficiente?
	"v", # A inovação é um componente crucial na gestão moderna?
	"v", # A resistência a mudanças é um desafio comum enfrentado pelos gestores?
	"v", # A análise SWOT é uma ferramenta de gestão que avalia forças, fraquezas, oportunidades e ameaças?
	"f", # A gestão de conflitos não é necessária em um ambiente de trabalho harmonioso?
	"v", # O planejamento estratégico é uma responsabilidade dos gestores de nível superior?
	"v", # Todos os gestores devem ter habilidades de negociação?
	"f", # A motivação dos funcionários não afeta diretamente a produtividade da empresa?
	"v", # A gestão de recursos humanos inclui o recrutamento, a seleção e a formação de funcionários?
	"f", # A tecnologia não tem impacto significativo na gestão de projetos?
	"v", # O trabalho em equipe pode ser promovido por meio de atividades de team building?
	"v", # O gestor deve ser um exemplo de comportamento ético para a equipe?
	"v", # O controle de custos é uma parte essencial da gestão financeira?
	"v", # A gestão de risco envolve identificar, avaliar e mitigar riscos potenciais?
	"f", # A comunicação descendente é a única forma de comunicação eficaz em uma empresa?
	"v", # O treinamento e desenvolvimento contínuo dos funcionários é crucial para a competitividade da empresa?
	"f", # A tomada de decisão deve sempre ser feita de forma centralizada?
	"v", # A análise de dados pode ajudar a tomar decisões mais informadas na gestão?
	"v", # A transparência na gestão aumenta a confiança dos funcionários?
	"f", # A avaliação de desempenho é uma prática desnecessária em empresas pequenas?
	"v", # O empowerment dos funcionários pode levar a uma maior satisfação no trabalho?
	"f"  # O gestor deve evitar qualquer forma de inovação para manter a estabilidade da empresa?
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

var edicoes = [
	"o curso",
	"a turma",
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
	var edicao_aleatorio = randi_range(0, 1) #randomiza um numero de 0 a 1
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
				tarefa = "Edita "+ edicoes[edicao_aleatorio] + " do registo com o ba " + ba + "!"
				print("adicionou tarefaaaaaa")
			BaIgual = false
		Global.escolhida_tarefa = 3
		Global.nome_tarefa = ba
		edicao_tarefa = edicoes[edicao_aleatorio]
	
	return tarefa #Vai retornar a tarefa randomizada
	pass
	
var nome_tarefa; var escolhida_tarefa; var edicao_tarefa
var tarefa_nome_escolhido = ["",
	"",
	"",
	""]
var tarefa_escolhida = ["",
	"",
	"",
	""]
var edicao_escolhida = ["",
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
			Global.edicao_escolhida[i] = Global.edicao_tarefa
			break # Dá break ao for
	pass 
	
var tarefa_realizada_visible = false
func aparecerTarefa_Realizada():
	Global.tarefa_realizada_visible = true
	var timer : Timer = Timer.new()
	add_child(timer)
	timer.one_shot = true
	timer.autostart = false
	timer.wait_time = 3.0
	timer.timeout.connect(_timer_Timeout)
	timer.start()
		
		#get_tree().change_scene_to_file("res://character/scenes/node_2d.tscn")
func _timer_Timeout():
	Global.tarefa_realizada_visible = false
	
func carregarCena():
	# Carrega a próxima cena para onde queremos transicionar
	#var cena_transicao = load("res://Parte_da_luta/boss/luta.tscn")  
	# Transição suave de cena
	get_tree().change_scene_to_file("res://Parte_da_luta/boss/luta.tscn")
