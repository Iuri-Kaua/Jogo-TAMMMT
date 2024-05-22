extends StaticBody2D

var velocidade: float = 500.0
var x_minimo : float = 45
var x_maximo : float = 435


func _process(delta):
	movimento(delta)
	limite()


func movimento(delta : float) -> void:
	if Input.is_action_pressed("mv-esquerdo"):
		position.x -= velocidade * delta
	elif Input.is_action_pressed("mv-direito"):
		position.x += velocidade * delta


func limite() -> void:
	position.x = clamp(position.x, x_minimo, x_maximo)
