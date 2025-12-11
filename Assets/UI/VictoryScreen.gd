extends Control

const P1_MANTIS_VICTORY    := "res://Fighters/Praying Mantis/Praying Mantis WINSCREEN/winscreen.png"
const P1_DRAGONFLY_VICTORY := "res://Assets/UI/Dragonfly Win Screen/Win screen Dragonfly 1.png"
const P2_MANTIS_VICTORY    := "res://Fighters/Praying Mantis/Praying Mantis WINSCREEN/winscreen.png"
const P2_DRAGONFLY_VICTORY := "res://Assets/UI/Dragonfly Win Screen/Dragonfly Win Screen Player 2.png"

@onready var winner_image: TextureRect = $CenterContainer/WinnerImage
@onready var button_main_menu: Button  = $ButtonMainMenu


func _ready() -> void:
	_update_winner_image()
	
	call_deferred("_focus_button")


func _focus_button() -> void:
	if is_inside_tree() and button_main_menu:
		button_main_menu.grab_focus()


func _update_winner_image() -> void:
	var winner_id: int = Global.last_winner_player_id
	var insect: String = Global.last_winner_insect

	var tex_path := ""

	match winner_id:
		1:
			match insect:
				"Mantis":
					tex_path = P1_MANTIS_VICTORY
				"Dragonfly":
					tex_path = P1_DRAGONFLY_VICTORY
		2:
			match insect:
				"Mantis":
					tex_path = P2_MANTIS_VICTORY
				"Dragonfly":
					tex_path = P2_DRAGONFLY_VICTORY

	if tex_path != "":
		winner_image.texture = load(tex_path)
	else:
		print("No victory image for Player %d as %s" % [winner_id, insect])
		winner_image.texture = null


func _on_button_main_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://Assets/UI/menu.tscn")
