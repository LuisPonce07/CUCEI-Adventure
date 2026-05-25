extends Control

@onready var barra = $ProgressBar

var progreso = []
var destino = ""

func _ready():
	destino = Global.escena_proxima
	
	if destino == "":
		print("!!! ERROR: El Global no me dio ninguna ruta para cargar")
		return

	var error = ResourceLoader.load_threaded_request(destino)
	if error != OK:
		print("!!! ERROR: Godot no encuentra el archivo: ", destino)

func _process(_delta):
	@warning_ignore("shadowed_variable")
	var destino = Global.escena_proxima
	@warning_ignore("shadowed_variable")
	var progreso = []
	var estado = ResourceLoader.load_threaded_get_status(destino, progreso)
	
	if progreso.size() > 0:
		var valor = progreso[0] * 100
		barra.value = valor
		print("Estado de carga: ", valor, "% - Estado: ", estado)
	
	if estado == ResourceLoader.THREAD_LOAD_LOADED:
		print("--- TODO LISTO, CAMBIANDO ESCENA ---")
		var escena = ResourceLoader.load_threaded_get(destino)
		get_tree().change_scene_to_packed(escena)
