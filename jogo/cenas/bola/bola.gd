extends Area2D

@onready var timer_da_bola : Timer = $Timer
@onready var som_impacto_bloco : AudioStreamPlayer = $AudioStreamPlayer
@onready var som_impacto_paddle : AudioStreamPlayer = $AudioStreamPlayer2
@onready var som_impacto_tela : AudioStreamPlayer = $AudioStreamPlayer3
@onready var botao_lanca = $controle/cima


var velocidade : float = 300.0
var posicao_inicial : Vector2 = Vector2(240,660)
var direcao_inicial : Vector2 = Vector2(0,0)
var nova_direcao : Vector2 = Vector2(0,0)
var primeiro_lancamento : bool = true
var caiu_da_tela : bool = false

var x_minimmo : float = 0
var x_maxmimo : float = 480
var y_minimmo : float = 0
var y_maxmimo : float = 750

func _ready():
	timer_da_bola.one_shot = true
	resetar_bola()
	


func _process(delta):
	if primeiro_lancamento:
		if Input.is_action_just_pressed("lancar_bola"):
			botao_lanca.visible = false

			escolher_direcao()
			primeiro_lancamento = false
	movimentar(delta)
	verificar_bola()


func resetar_bola() -> void:
	position = posicao_inicial
	botao_lanca.visible = true


func escolher_direcao() -> void:
	var x_aleatorio = [-1, 1].pick_random()
	
	direcao_inicial = Vector2(x_aleatorio, -1)
	nova_direcao = direcao_inicial


func movimentar(delta : float) -> void:
	position += nova_direcao * velocidade * delta


func verificar_bola() -> void:
	if position.y <= y_maxmimo:
		if position.y <= y_minimmo:
			som_impacto_tela.play()
			nova_direcao.y *= -1
		if (position.x <= x_minimmo) or (position.x >= x_maxmimo):
			som_impacto_tela.play()
			nova_direcao.x *= -1
	if position.y > y_maxmimo and not caiu_da_tela:
		timer_da_bola.start()
		caiu_da_tela = true
		


func sair_tela() -> void:
	nova_direcao = Vector2(0,0)
	primeiro_lancamento = true
	resetar_bola()

func _on_body_entered(body):
	if body.is_in_group("paddle"):
		som_impacto_paddle.play()
		nova_direcao.y *= -1
	elif body.is_in_group("bloco"):
		som_impacto_bloco.play()
		body.dano()
		nova_direcao.y *= -1

func _on_timer_timeout():
	sair_tela()
	caiu_da_tela = false
