extends StaticBody2D

@export var game_manager : Node2D

@export var vida : int

@export var vermelho : Color
@export var verde : Color
@export var azul : Color

func _ready():
	atualizar_cor()


func atualizar_cor() -> void :
	if vida == 3:
		modulate = verde
	elif vida == 2:
		modulate = azul
	elif vida == 1:
		modulate = vermelho
	else:
		modulate = Color.WHITE


func dano() -> void:
	vida -= 1
	if vida >= 1:
		atualizar_cor()
	else:
		game_manager.atualizar_contagem()
		queue_free()
