extends CharacterBody2D
var _state_machine



@export_category("Variables")
#@export var _move_speed: float = 150.0

@export var _friction: float = 0.3
@export var _acceleration: float = 0.2

@export_category("Objects")
@export var _animtaion_tree: AnimationTree = null

func _ready() -> void:
	_state_machine = _animtaion_tree["parameters/playback"]
	


func _physics_process(_delta: float) -> void:
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



