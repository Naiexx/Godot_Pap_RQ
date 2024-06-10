extends Control

# Tempo inicial em segundos (5 minutos = 300 segundos)
var initial_time : int = 300
var time_left : int = initial_time

# Referência ao Label
@onready var timer_label : Label = $Label

# Chama a função _process a cada frame
func _process(delta : float) -> void:
	if time_left > 0:
		# Reduz o tempo restante
		time_left -= delta
		# Atualiza o texto do Label
		timer_label.text = format_time(time_left)
	else:
		# Quando o tempo acabar, define o texto do Label como "Tempo esgotado!"
		timer_label.text = "Tempo esgotado!"

# Formata o tempo em minutos e segundos
func format_time(seconds : float) -> String:
	var minutes = int(seconds) / 60
	var secs = int(seconds) % 60
	return "%02d:%02d" % [minutes, secs]
