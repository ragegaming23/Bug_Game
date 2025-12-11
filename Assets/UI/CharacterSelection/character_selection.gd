extends Control

var current_player := 1

@onready var player_label: Label = $Label_Player
@onready var button_mantis: TextureButton = $Mantis/ButtonMantis
@onready var button_dragonfly: TextureButton = $Dragonfly/ButtonDragonfly

func _ready() -> void:
	button_mantis.grab_focus()
	player_label.text = "Player 1, choose your character"


func _on_mantis_pressed() -> void:
	_set_player_choice("Mantis")


func _on_dragonfly_pressed() -> void:
	_set_player_choice("Dragonfly")


func _set_player_choice(character_name: String) -> void:
	if current_player == 1:
		Global.player1_character = character_name
		current_player = 2
		player_label.text = "Player 2, choose your character"
		print("Player 1 chose ", character_name)
	else:
		Global.player2_character = character_name
		print("Player 2 chose ", character_name)
		_start_game()


func _start_game() -> void:
	print("Both players selected. Loading game...")
	var Chosen_stage = Global.Chosen_Stage
	await get_tree().process_frame
	_start_client_and_load_game()

func _start_client_and_load_game() -> void:
	LocalNetwork.Start_client()
	Global.load_scene(Global.Chosen_Stage)
