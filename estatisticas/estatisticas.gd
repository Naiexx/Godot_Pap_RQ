extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	%Mortes.text = str(Global.stats_mortes)
	%Tempo.text = str(Global.minutes)+":"+str(Global.seconds-1)
	%Perguntas_Certas.text = str(Global.stats_respostas_certas)
	%Perguntas_Erradas.text = str(Global.stats_respostas_erradas)
	%Tarefas_Realizadas.text = str(Global.progressoJogo)
