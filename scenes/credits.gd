extends Control


func _ready() -> void:
	pass # Replace with function body.


@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	pass


func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
