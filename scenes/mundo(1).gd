extends Node2D
class_name Mundo
@onready var fade = $CanvasLayer/IntroFade
@onready var texto = $CanvasLayer/IntroLabel


func _ready():

	print("MUNDO SCRIPT ACTIVO")


func iniciar_intro(frase, ruta):

	texto.text = frase
	texto.visible = true

	fade.visible = true
	fade.modulate.a = 0

	await get_tree().create_timer(1.5).timeout

	for i in range(20):

		fade.modulate.a += 0.05

		await get_tree().create_timer(0.03).timeout

	texto.visible = false

	get_tree().change_scene_to_file(ruta)
