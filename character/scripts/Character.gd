extends CharacterBody2D
var _state_machine

var aparecer_dialogo = false

@export_category("Variables")
#@export var _move_speed: float = 150.0

@export var _friction: float = 0.3
@export var _acceleration: float = 0.2

@export_category("Objects")
@export var _animtaion_tree: AnimationTree = null

func _ready() -> void:
	_state_machine = _animtaion_tree["parameters/playback"]
	


func _physics_process(_delta: float) -> void:
	if aparecer_dialogo == true && Input.is_action_pressed("interaction_e"): #Caso ele esteje em contacto com o NPC e clique no E o dialogo vai aparecer
		DialogueManager.show_example_dialogue_balloon(load("res://npc/scripts/main.dialogue"), "main") #Faz o Dialogo aparecer
		aparecer_dialogo = false
	_move()
	_animate()
	move_and_slide()
	
	
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

func _on_pc_body_entered(body):
	print("entrou")
	Global.activate_e = true #Caso ele entre na colisão no PC o SPRITE_E aparece


func _on_pc_body_exited(body):
	print("saiu")
	Global.activate_e = false #Caso ele saia da colisão no PC o SPRITE_E desaparece



func _on_area_npc_body_entered(body):
	aparecer_dialogo = true #Caso  ele entre em contacto com o NPC vai colocar essa variavel true
	print("entrou NPC")
	pass # Replace with function body.


func _on_area_npc_body_exited(body):
	aparecer_dialogo = false #Caso  ele entre em contacto com o NPC vai colocar essa variavel false
	print("saiu NPC")
	pass # Replace with function body.


func _on_quadro_tarefas_body_entered(body):
	print("entrou")
	Global.activate_e2 = true
	pass # Replace with function body.


func _on_quadro_tarefas_body_exited(body):
	Global.activate_e2 = false
	pass # Replace with function body.
