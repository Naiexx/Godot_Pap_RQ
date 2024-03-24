extends CharacterBody2D
var _player_ref = null
@onready var progress_bar = $TextureProgressBar
@onready var animation_player = owner.find_child("AnimationPlayer")
@export var tesoura_node : PackedScene

var time_since_last_shot = 0.0
var shoot_interval = 1.0

var healt : = 10:
	set(value):
		healt = Global.vidaboss
		progress_bar.value = healt #Guarda a vida do boss na barra de progresso

func take_damage(): # Tira vida ao boss
	progress_bar.value = Global.vidaboss

	if Global.vidaboss <= 0: # caso a vida do boss chegue ao fim a barra de progresso e o inimgo desaparecem e aparece uma animaçao
		_player_ref = null
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
		
		#get_tree().change_scene_to_file("res://character/scenes/node_2d.tscn")

func _timer_Timeout():
	get_tree().change_scene_to_file("res://character/scenes/node_2d.tscn")
	
func _on_area_2d_body_entered(_body) -> void: # se algo colidar nesta area do grupo character irá receber um corpo
	if _body.is_in_group("character"):
		_player_ref = _body
		

func _on_area_2d_body_exited(_body) -> void: # se algo sair desta area do grupo character irá ficar sem corpo
	if _body.is_in_group("character"):
		_player_ref = null
		
		
func get_direction():
	return global_position.direction_to(_player_ref.global_position)
	
func shoot():
	var tesoura = tesoura_node.instantiate() # esta varaivel guarda a cena da tesoura
	
	tesoura.position = global_position
	tesoura.direction = global_position.direction_to(_player_ref.global_position)# o disparo ira dirigir se para a posiçao do rato
	get_tree().current_scene.call_deferred("add_child",tesoura)# faz o sprite aparecer na tela

func _physics_process(delta: float) -> void:
	take_damage()
	if Global.vidaplayer == 0:
		queue_free()
		
	if _player_ref != null: # caso o personagem tenho recebido um corpo o inimigo irá segui-lo
		var _direction: Vector2 = global_position.direction_to(_player_ref.global_position)
		
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



