extends Control

func _on_play_pressed():
	Global.ir_a_escena("res://scenes/mundo.scn")

func _on_exit_pressed():
	get_tree().quit()
