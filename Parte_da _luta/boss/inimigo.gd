extends CharacterBody2D
var _player_ref = null
@onready var progress_bar = $UI/ProgressBar
@onready var animation_player = owner.find_child("AnimationPlayer")
@export var tesoura_node : PackedScene

var healt : = 10:
	set(value):
		healt = Global.vidaboss
		progress_bar.value = healt #Guarda a vida do boss na barra de progresso

func take_damage(): # Tira vida ao boss
	progress_bar.value = Global.vidaboss
	if Global.vidaboss <= 0: # caso a vida do boss chegue ao fim a barra de progresso e o inimgo desaparecem e aparece uma animaçao
			progress_bar.visible = false
			$".".visible = false
			$AnimationPlayer.play("Eliminaste_JJ")

func _on_area_2d_body_entered(_body) -> void: # se algo colidar nesta area do grupo character irá receber um corpo
	if _body.is_in_group("character"):
		_player_ref = _body

func _on_area_2d_body_exited(_body) -> void: # se algo sair desta area do grupo character irá ficar sem corpo
	if _body.is_in_group("character"):
		_player_ref = null

func _physics_process(delta: float) -> void:
	if _player_ref != null: # caso o personagem tenho recebido um corpo o inimigo irá segui-lo
		var _direction: Vector2 = global_position.direction_to(_player_ref.global_position)
		velocity = _direction * 70
		move_and_slide()
		progress_bar.visible = true
		take_damage()

