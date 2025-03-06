extends RigidBody3D

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

# Chamada em cada frame. 'delta' é o tempo decorrido desde o frame anterior.
	# Em outras palavras: atualiza o jogo em tempo real
func _process(delta: float) -> void:
	var input = Vector3.ZERO
	input.x = Input.get_axis("mover_esquerda", "mover_direita")
	input.z = Input.get_axis("mover_frente", "mover_tras")
	
	apply_central_force(input * 1200.0 * delta)
	
	if Input.is_action_just_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
