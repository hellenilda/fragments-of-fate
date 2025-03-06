extends RigidBody3D

var mouse_sensivity := 0.001
var twist_input := 0.0
var pitch_input := 0.0

# Chamada toda vez que o player entra na cena
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
		
	$TwistPivot.rotate_y(twist_input)
	$TwistPivot/PitchPivot.rotate_x(pitch_input)
	$TwistPivot/PitchPivot.rotation.x = clamp(
		$TwistPivot/PitchPivot.rotation.x,
		-0.5,
		0.5
	)
	twist_input = 0.0
	pitch_input = 0.0

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			twist_input = - event.relative.x * mouse_sensivity
			pitch_input = - event.relative.y * mouse_sensivity
