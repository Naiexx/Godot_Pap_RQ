extends Node2D

@export var tesoura_node : PackedScene
@onready var sprite = $Sprite2D
var player_ref
var time_since_last_shot = 0.0
var shoot_interval = 2.0

func _ready():
	set_process_input(true) # Habilita a captura de eventos de entrada

func _input(event):
	if event is InputEventMouseMotion:
		# Obtém a posição do mouse em relação à cena
		var mouse_position = get_global_mouse_position()

		# Calcula a direção do mouse em relação ao jogador
		var direction_to_mouse = (mouse_position - global_position).normalized()

		# Calcula a rotação da sprite para apontar na direção do mouse
		var angle = atan2(direction_to_mouse.y, direction_to_mouse.x)
		sprite.rotation = angle
		
func shoot():
	var tesoura = tesoura_node.instantiate() # esta varaivel guarda a cena da tesoura
	
	tesoura.position = sprite.global_position
	tesoura.direction = (get_global_mouse_position() - sprite.global_position).normalized() # o disparo ira dirigir se para a posiçao do rato
	
	get_tree().current_scene.call_deferred("add_child",tesoura)# faz o sprite aparecer na tela

func _physics_process(delta):
	if player_ref:
		# Define a posição da sprite ao lado do jogador
		global_position = player_ref.global_position + Vector2(50, 0) # Ajuste a posição conforme necessário
	time_since_last_shot += delta
	if Input.is_action_just_pressed("atirar tesoura"):
		if time_since_last_shot >= shoot_interval:
			shoot()
			time_since_last_shot = 0.0
