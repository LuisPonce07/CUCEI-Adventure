extends CanvasLayer

func _ready():
	hide() 

func _input(event):
	if event is InputEventKey and event.pressed:
		print("Tecla física detectada: ", event.as_text())

	if event.is_action_pressed("pause") or event.is_action_pressed("ui_cancel"):
		print("¡Acción de pausa activada!")
		toggle_pausa()

func toggle_pausa():
	var nuevo_estado = !get_tree().paused
	get_tree().paused = nuevo_estado
	
	visible = nuevo_estado 
	
	if nuevo_estado:
		print("Juego Pausado")
	else:
		print("Juego Reanudado")

func _on_continue_pressed():
	toggle_pausa()

func _on_exit_pressed():
	get_tree().paused = false 
	get_tree().change_scene_to_file("res://scenes/menu_principal.tscn")
	
