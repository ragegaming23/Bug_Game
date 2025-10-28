extends Control

func _ready() -> void:
	# Small delay to let LoadingScreen actually render
	await get_tree().process_frame
	_start_client_and_load_game()

func _start_client_and_load_game() -> void:
	LocalNetwork.Start_client()
	get_tree().change_scene_to_file("res://Test area/test scene.tscn")
