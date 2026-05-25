extends Control

@onready var musica_fondo = $AudioStreamPlayer

func _ready():
	if not musica_fondo.playing:
		musica_fondo.play()
