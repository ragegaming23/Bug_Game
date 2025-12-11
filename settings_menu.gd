extends Control

@onready var button_back: Button = $MarginContainer/VBoxContainer/ButtonBack
@onready var button_quit: Button = $MarginContainer/VBoxContainer/ButtonQuit

func _ready() -> void:
	visible = false

	if not button_back.pressed.is_connected(_on_button_back_pressed):
		button_back.pressed.connect(_on_button_back_pressed)

	if not button_quit.pressed.is_connected(_on_button_quit_pressed):
		button_quit.pressed.connect(_on_button_quit_pressed)


func _on_button_back_pressed() -> void:
	visible = false
	var parent := get_parent()
	if parent and parent.has_node("Start"):
		parent.get_node("Start").grab_focus()


func _on_button_quit_pressed() -> void:
	get_tree().quit()
