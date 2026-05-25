extends Control

const RUTA_GUARDADO = "user://partida.json"

func _ready():
	if has_node("Load"):
		$Load.disabled = not FileAccess.file_exists(RUTA_GUARDADO)


func _on_play_pressed():
	nueva_partida()
	Global.ir_a_escena("res://scenes/mundo.tscn")


func _on_load_pressed() -> void:
	if cargar_partida():
		Global.ir_a_escena("res://scenes/mundo.tscn")
	else:
		print("No hay partida guardada")


func _on_credits_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/credits.tscn")


func _on_exit_pressed():
	get_tree().quit()


func nueva_partida():
	Global.nivel = 1
	Global.experiencia = 0
	Global.exp_max = 100

	Global.npcs_derrotados.clear()

	Global.equipo.clear()
	Global.equipo.append("Lovelace")

	Global.personajes_desbloqueados.clear()
	Global.personajes_desbloqueados.append("Lovelace")

	Global.puede_pelear = true

	# Reiniciar vida de todos los personajes
	for nombre in Global.base_personajes.keys():
		Global.base_personajes[nombre]["hp_actual"] = Global.base_personajes[nombre]["hp"]

	print("Nueva partida iniciada")


func cargar_partida():
	if not FileAccess.file_exists(RUTA_GUARDADO):
		return false

	var archivo = FileAccess.open(RUTA_GUARDADO, FileAccess.READ)

	if archivo == null:
		print("No se pudo abrir el archivo de guardado")
		return false

	var contenido = archivo.get_as_text()
	archivo.close()

	var datos = JSON.parse_string(contenido)

	if datos == null:
		print("Error al leer el JSON")
		return false

	Global.nivel = datos.get("nivel", 1)
	Global.experiencia = datos.get("experiencia", 0)
	Global.exp_max = datos.get("exp_max", 100)

	Global.equipo = datos.get("equipo", ["Lovelace"])
	Global.personajes_desbloqueados = datos.get("personajes_desbloqueados", ["Lovelace"])
	Global.npcs_derrotados = datos.get("npcs_derrotados", [])
	Global.puede_pelear = datos.get("puede_pelear", true)

	if datos.has("base_personajes"):
		Global.base_personajes = datos["base_personajes"]

	# Protección por si el guardado está vacío o corrupto
	if Global.equipo.size() == 0:
		Global.equipo.append("Lovelace")

	if not Global.base_personajes.has(Global.equipo[0]):
		Global.equipo.clear()
		Global.equipo.append("Lovelace")

	if Global.personajes_desbloqueados.size() == 0:
		Global.personajes_desbloqueados.append("Lovelace")

	print("Partida cargada correctamente")
	print("Equipo cargado:", Global.equipo)

	return true
