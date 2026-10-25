extends Node2D

var save_path = "user://savegame.save"

func _ready() -> void:
	if Global.muat_save_lama == true:
		await get_tree().process_frame
		load_game()
		Global.muat_save_lama = false

func save_game():
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	var data = {
		"player_x": $player.global_position.x,
		"player_y": $player.global_position.y,
		"hantu_x": $hantu.global_position.x,
		"hantu_y": $hantu.global_position.y
	}
	file.store_line(JSON.stringify(data))
	print("Game & posisi hantu berhasil disimpan!")

func load_game():
	if not FileAccess.file_exists(save_path):
		return
		
	var file = FileAccess.open(save_path, FileAccess.READ)
	var line = file.get_line()
	
	if line.is_empty():
		return
		
	var data = JSON.parse_string(line)
	
	if data is Dictionary:
		if has_node("player") and data.has("player_x") and data.has("player_y"):
			$player.global_position = Vector2(data["player_x"], data["player_y"])
			
		if has_node("hantu") and data.has("hantu_x") and data.has("hantu_y"):
			$hantu.global_position = Vector2(data["hantu_x"], data["hantu_y"])
			
		print("Game berhasil dimuat!")

func _on_back_game_pressed() -> void:
	get_tree().change_scene_to_file("res://scene/main_menu.tscn")

func _on_button_3_pressed() -> void:
	save_game()
