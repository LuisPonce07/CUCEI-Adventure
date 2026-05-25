extends CanvasLayer

@onready var fondo = $TextureRect
@onready var caja = $VBoxContainer
@onready var boton_continue = $VBoxContainer/continue
@onready var boton_exit = $VBoxContainer/exit

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	
	fondo.mouse_filter = Control.MOUSE_FILTER_PASS
	caja.mouse_filter = Control.MOUSE_FILTER_PASS
	boton_continue.mouse_filter = Control.MOUSE_FILTER_STOP
	boton_exit.mouse_filter = Control.MOUSE_FILTER_STOP

	hide()

	print("PAUSA CARGADA")

func _input(event):
	if event.is_action_pressed("pause") or event.is_action_pressed("ui_cancel"):
		toggle_pausa()

func toggle_pausa():
	var pausado = !get_tree().paused
	get_tree().paused = pausado
	visible = pausado

	if pausado:
		print("Juego Pausado")
	else:
		print("Juego Reanudado")

func _on_continue_pressed():
	print("Continue presionado")
	get_tree().paused = false
	hide()

func _on_exit_pressed():
	print("Exit presionado")
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
