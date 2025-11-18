extends Control
var Chosen_stage = Global.Chosen_Stage

func _ready() -> void:
	await get_tree().process_frame
	_start_client_and_load_game()

func _start_client_and_load_game() -> void:
	LocalNetwork.Start_client()
	Global.load_scene(Chosen_stage)
	#get_tree().change_scene_to_file("res://Test area/test scene.tscn")
