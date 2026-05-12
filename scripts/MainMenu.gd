extends Control

func _on_play_pressed():
	Global.ir_a_escena("res://scenes/mundo.scn")

func _on_exit_pressed():
	get_tree().quit()
	

func _on_credits_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/credits.tscn")
