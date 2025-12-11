extends Control

@onready var start_button:  TextureButton = $Start
@onready var options_button: TextureButton = $Options
@onready var loading_screen: TextureRect= $LoadingScreen
@onready var settings_menu: Control = $SettingsMenu

@onready var back_button: Button = $SettingsMenu/MarginContainer/VBoxContainer/ButtonBack
@onready var quit_button: Button = $SettingsMenu/MarginContainer/VBoxContainer/ButtonQuit


func _ready() -> void:
	if settings_menu:
		settings_menu.visible = false
		settings_menu.mouse_filter = Control.MOUSE_FILTER_STOP

	if back_button and quit_button:
		back_button.focus_mode = Control.FOCUS_ALL
		quit_button.focus_mode = Control.FOCUS_ALL

		back_button.focus_neighbor_bottom = back_button.get_path_to(quit_button)
		quit_button.focus_neighbor_top   = quit_button.get_path_to(back_button)

	call_deferred("_focus_start_button")


func _focus_start_button() -> void:
	if is_inside_tree() and start_button:
		start_button.grab_focus()


func _process(_delta: float) -> void:
	pass


func _on_start_pressed() -> void:
	loading_screen.visible = true
	await get_tree().create_timer(1.5).timeout
	LocalNetwork.Start_client()
	get_tree().change_scene_to_file("res://Assets/UI/map_selection.tscn")


func _on_options_pressed() -> void:
	if not settings_menu:
		return

	settings_menu.visible = true

	if back_button:
		back_button.call_deferred("grab_focus")


func _on_ButtonBack_pressed() -> void:
	if settings_menu:
		settings_menu.visible = false

	if start_button:
		start_button.call_deferred("grab_focus")


func _on_ButtonQuit_pressed() -> void:
	get_tree().quit()


func _on_button_back_pressed() -> void:
	pass


func _on_button_quit_pressed() -> void:
	pass
