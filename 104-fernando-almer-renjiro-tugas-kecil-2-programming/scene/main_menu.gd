extends Control

var save_path = "user://savegame.save"

# FUNGSI UNTUK TOMBOL LOAD GAME (Button)
func _on_button_pressed() -> void:
	# Cek dulu apakah file savenya benar-benar ada
	if FileAccess.file_exists(save_path):
		Global.muat_save_lama = true # Cukup nyalakan penandanya saja!
		get_tree().change_scene_to_file("res://scene/game.tscn")
	else:
		print("Belum ada file simpanan!")

# FUNGSI UNTUK TOMBOL NEW GAME (Button1)
func _on_button_1_pressed() -> void:
	Global.muat_save_lama = false
	get_tree().change_scene_to_file("res://scene/game.tscn")

func _on_credit_pressed() -> void:
	get_tree().change_scene_to_file("res://scene/credit.tscn")

func _on_exit_pressed() -> void:
	get_tree().quit()
