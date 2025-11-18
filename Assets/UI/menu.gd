extends Control

func _ready():
	$Start.grab_focus()
	
	
func _process(_delta: float) -> void:
	pass


func _on_start_pressed() -> void:
	$LoadingScreen.visible=true
	await get_tree().create_timer(1.5).timeout
	LocalNetwork.Start_client()
	get_tree().change_scene_to_file("res://Assets/UI/map_selection.tscn")


func _on_options_pressed() -> void:
	pass 


func _on_quit_pressed() -> void:
	get_tree() .quit()
