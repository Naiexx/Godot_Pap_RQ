extends CharacterBody2D
var _state_machine

@export var tesoura_node : PackedScene
@onready var progress_bar2 = $UI/ProgressBar
@export_category("Variables")
#@export var _move_speed: float = 150.0

@export var _friction: float = 0.3
@export var _acceleration: float = 0.2

@export_category("Objects")
@export var _animtaion_tree: AnimationTree = null



var time_since_last_shot = 0.0
var shoot_interval = 2.0


var healt2 : = 10:
	set(value):
		healt2 = Global.vidaplayer
		progress_bar2.value = healt2 #Guarda a vida do boss na barra de progresso


func take_damage2(): # Tira vida ao boss
	progress_bar2.value = Global.vidaplayer

	if Global.vidaplayer <= 0: # caso a vida do boss chegue ao fim a barra de progresso e o inimgo desaparecem e aparece uma animaçao
		var timer : Timer = Timer.new()
		add_child(timer)
		timer.one_shot = true
		timer.autostart = false
		timer.wait_time = 2.0
		timer.timeout.connect(_timer_Timeout)
		timer.start()
		progress_bar2.visible = false
		$".".visible = false
		$UI/Label.visible = true
		
		#get_tree().change_scene_to_file("res://character/scenes/node_2d.tscn")
func _timer_Timeout():
	get_tree().change_scene_to_file("res://character/scenes/node_2d.tscn")

func _ready() -> void:
	_state_machine = _animtaion_tree["parameters/playback"]
	 # Inicializa o timer
	# Define o intervalo do timer como 2 segundos
	# Conecta o sinal 'timeout' do timer para a função _on_ShootTimer_timeout
	#shoot_timer.connect("timeout", self, "_on_ShootTimer_timeout")
	# Adiciona o timer como filho deste nó para que ele seja ativado corretamente


func _physics_process(_delta: float) -> void:
	_move()
	_animate()
	move_and_slide()
	take_damage2()
	time_since_last_shot += _delta
	if Input.is_action_just_pressed("atirar tesoura"):
		if time_since_last_shot >= shoot_interval:
			shoot()
			time_since_last_shot = 0.0


func _move() -> void:
	var _direction: Vector2 = Vector2(
		Input.get_axis("move_left", "move_right"), #Valor de X para horizontal
		Input.get_axis("move_up", "move_down") #Valor de y para vertical
	)
	
	if _direction != Vector2.ZERO:
		_animtaion_tree["parameters/idle/blend_position"] = _direction #Pega o idle do AnimationTree e configura o X e o Y conforme a direçao
		_animtaion_tree["parameters/walk/blend_position"] = _direction #Pega o walk do AnimationTree e configura o X e o Y		
		velocity.x = lerp(velocity.x, _direction.normalized().x * Global._move_speed, _acceleration)
		velocity.y = lerp(velocity.y, _direction.normalized().y * Global._move_speed, _acceleration)
		return
		
	velocity.x = lerp(velocity.x, _direction.normalized().x * Global._move_speed, _friction)
	velocity.y = lerp(velocity.y, _direction.normalized().y * Global._move_speed, _friction)
	#velocity = _direction.normalized() * _move_speed
		
func _animate() -> void:
	if velocity.length() > 3: #Se a velocidade do personagem for diferente de 0, Significa que esta a andar
		_state_machine.travel("walk")
		return
	_state_machine.travel("idle") #Se for 0 ele esta parado
	

func shoot():
	var tesoura = tesoura_node.instantiate() # esta varaivel guarda a cena da tesoura
	
	tesoura.position = global_position
	tesoura.direction = (get_global_mouse_position() - global_position).normalized() # o disparo ira dirigir se para a posiçao do rato
	
	get_tree().current_scene.call_deferred("add_child",tesoura)# faz o sprite aparecer na tela
	

#func _input(event):
	#if event.is_action_pressed("atirar tesoura"): 
		#shoot()
