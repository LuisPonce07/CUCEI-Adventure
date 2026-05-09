extends CanvasLayer

func _ready():
	hide() # Asegúrate de que empiece oculto

func _input(event):
	# Si presionas CUALQUIER tecla, esto lo imprimirá
	if event is InputEventKey and event.pressed:
		print("Tecla física detectada: ", event.as_text())

	# Verificamos la acción "pause" o el "ui_cancel" nativo
	if event.is_action_pressed("pause") or event.is_action_pressed("ui_cancel"):
		print("¡Acción de pausa activada!")
		toggle_pausa()

func toggle_pausa():
	var nuevo_estado = !get_tree().paused
	get_tree().paused = nuevo_estado
	
	# ¡IMPORTANTE! Si no pones esto, no verás el menú
	visible = nuevo_estado 
	
	if nuevo_estado:
		print("Juego Pausado")
	else:
		print("Juego Reanudado")

func _on_continuar_pressed():
	toggle_pausa()

func _on_salir_pressed():
	# Despausamos antes de irnos
	get_tree().paused = false 
	get_tree().change_scene_to_file("res://scenes/menu_principal.tscn")
	


func _on_continue_pressed() -> void:
	pass # Replace with function body.


func _on_exit_pressed() -> void:
	pass # Replace with function body.
