extends CharacterBody2D

@onready var effects = $Effects2
@onready var progress_bar = $TextureProgressBar
@onready var animation_player = owner.find_child("AnimationPlayer")
@export var tesoura_node : PackedScene
@onready var hand: Node = get_node("Node2D")
@onready var sprite = $AnimatedSprite2D
@onready var sprite2 = $Node2D/AnimatedSprite2D1


var time_since_last_shot = 0.0
var shoot_interval = 1.0

var healt : = 10:
	set(value):
		healt = Global.vidaboss
		progress_bar.value = healt #Guarda a vida do boss na barra de progresso

func take_damage(): # Tira vida ao boss
	progress_bar.value = Global.vidaboss

	if Global.vidaboss <= 0: # caso a vida do boss chegue ao fim a barra de progresso e o inimgo desaparecem e aparece uma animaçao
		Global._player_ref = null
		$AnimatedSprite2D.play("morte")
		progress_bar.visible = false
		#$".".visible = false
		$AnimationPlayer.play("Eliminaste_JJ")
		var timer2 : Timer = Timer.new()
		add_child(timer2)
		timer2.one_shot = true
		timer2.autostart = false
		timer2.wait_time = 2.0
		timer2.timeout.connect(_timer_Timeout)
		timer2.start()
		$Timer.start
		#get_tree().change_scene_to_file("res://character/scenes/node_2d.tscn")
		
func _on_timer_timeout():
	get_tree().reload_current_scene()

func _timer_Timeout():
	get_tree().change_scene_to_file("res://character/scenes/node_2d.tscn")
	Global.vidaboss = 10
	Global.vidaplayer = 10
	
func _on_area_2d_body_entered(_body) -> void: # se algo colidar nesta area do grupo character irá receber um corpo
	if _body.is_in_group("character"):
		Global._player_ref = _body
		

func _on_area_2d_body_exited(_body) -> void: # se algo sair desta area do grupo character irá ficar sem corpo
	if _body.is_in_group("character"):
		Global._player_ref = null
		
		
func get_direction():
	return global_position.direction_to(Global._player_ref.global_position)
	
func direcao():
	var direction_to_player = (Global._player_ref.global_position - global_position).normalized()

# Calcula a rotação da sprite para apontar na direção do jogador
	var angle = atan2(direction_to_player.y, direction_to_player.x)
	$Node2D/AnimatedSprite2D1.rotation = angle

# Define a posição da sprite ao lado do jogador
	#global_position = Global._player_ref.global_position + Vector2(50, 0) # Ajuste a posição conforme necessário
	
	
func shoot():
	var tesoura = tesoura_node.instantiate() # esta varaivel guarda a cena da tesoura
	

	tesoura.position = sprite2.global_position
	tesoura.direction = sprite2.global_position.direction_to(Global._player_ref.global_position +  Vector2(0, -20))# o disparo ira dirigir se para a posiçao do rato
	get_tree().current_scene.call_deferred("add_child",tesoura)# faz o sprite aparecer na tela
	
func danoRecebido():
	if Global.danoRecebido2 == true:
		effects.play("hurtBlink")
		var timer : Timer = Timer.new()
		add_child(timer)
		timer.one_shot = true
		timer.autostart = false
		timer.wait_time = 0.7
		timer.timeout.connect(teste)
		timer.start()
		Global.danoRecebido2 = false
		
func teste():
	effects.play("RESET")
	

func _physics_process(delta: float) -> void:
	take_damage()
	danoRecebido()
	
	if Global._player_ref != null: # caso o personagem tenho recebido um corpo o inimigo irá segui-lo
		direcao()
		$AnimatedSprite2D.play("correr")
		var _direction: Vector2 = global_position.direction_to(Global._player_ref.global_position)
		
		
		if _direction.x > 0:
			$AnimatedSprite2D.flip_h = true
		else:
			$AnimatedSprite2D.flip_h = false
		velocity = _direction * 70
		move_and_slide()
		
		time_since_last_shot += delta
		if time_since_last_shot >= shoot_interval:
			shoot()
			time_since_last_shot = 0.0
	
	if Global.vidaplayer == 0:
		Global._player_ref = null
		$AnimatedSprite2D.play("idle")
		Global.acabar = true





