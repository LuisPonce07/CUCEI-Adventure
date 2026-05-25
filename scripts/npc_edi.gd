extends Node2D

@export var id_npc = "npc_edi"

@export var enemigo_data = {
	"nombre": "Edi",
	"hp": 160,
	"atk": 20,
	"spd": 8,

	"sprite": "res://enemigos/EdiFrontal.png",
	"fondo": "res://fondos/Fondo3.jpeg",

	"musica": "res://musica/Beneath_The_Chemistry_Wing.mp3",

	"habilidades": [
		{
			"nombre": "Impacto de Mazo",
			"tipo": "daño",
			"mult": 1.2,
			"usos": 12
		},
		{
			"nombre": "Megaestructura",
			"tipo": "ultimate",
			"mult": 2.0,
			"usos": 3
		}
	]
}


func _ready():

	if id_npc in Global.npcs_derrotados:
		queue_free()


func _on_area_2d_body_entered(body):

	if not Global.puede_pelear:
		return

	if body.name == "player":

		Global.puede_pelear = false

		Global.player_position = body.global_position
		Global.npc_actual = id_npc
		Global.enemigo_actual = enemigo_data

		call_deferred("cambiar_a_batalla")


func cambiar_a_batalla():

	var frase = ""

	match enemigo_data["nombre"]:

		"Volt":
			frase = "La velocidad decide quién sobrevive."

		"Edi":
			frase = "La fuerza derrumba cualquier muro."

		"Viktor":
			frase = "No hay piedad en la guerra."

		"Leo":
			frase = "La ciencia siempre encuentra una forma."

		_:
			frase = "Prepárate..."

	# ================= CANVAS =================

	var canvas = CanvasLayer.new()
	canvas.layer = 100

	get_tree().current_scene.add_child(canvas)

	# ================= FADE =================

	var fade = ColorRect.new()

	fade.color = Color.BLACK
	fade.modulate.a = 0
	fade.set_anchors_preset(Control.PRESET_FULL_RECT)

	canvas.add_child(fade)

	# ================= TEXTO =================

	var texto = Label.new()

	texto.text = frase

	texto.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	texto.vertical_alignment = VERTICAL_ALIGNMENT_CENTER

	texto.set_anchors_preset(Control.PRESET_FULL_RECT)

	texto.add_theme_font_size_override("font_size", 42)

	canvas.add_child(texto)

	# ================= ESPERA =================

	await get_tree().create_timer(1.2).timeout

# ================= PARPADEOS =================

	for i in range(3):

		fade.modulate.a = 0.5

		await get_tree().create_timer(0.12).timeout

		fade.modulate.a = 0

		await get_tree().create_timer(0.12).timeout

# ================= PAUSA DRAMÁTICA =================

	await get_tree().create_timer(0.5).timeout

# ================= FADE FINAL =================

	for i in range(35):

		fade.modulate.a += 0.03

		await get_tree().create_timer(0.04).timeout

# ================= BATALLA =================

	get_tree().change_scene_to_file("res://scenes/batalla.tscn")

func _cargar_batalla():

	get_tree().change_scene_to_file("res://scenes/batalla.tscn")
