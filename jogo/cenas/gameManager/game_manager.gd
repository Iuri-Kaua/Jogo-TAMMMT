extends Node2D

@export var blocos : Node2D 
var blocos_na_fase : int = 0

@export var proxima_fase : String
@onready var timer : Timer = $Timer

func _ready():
	buscar_blocos()


func _process(delta):
	pass


func buscar_blocos() -> void:
	for blocos in blocos.get_children():
		blocos_na_fase += 1


func atualizar_contagem() -> void:
	blocos_na_fase -=1
	if blocos_na_fase <= 0:
		timer.start()


func _on_timer_timeout():
	get_tree().change_scene_to_file(proxima_fase)

	pass # Replace with function body.
