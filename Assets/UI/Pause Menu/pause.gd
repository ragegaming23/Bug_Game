extends CanvasLayer
@onready var control_screen: TextureRect= $"Pause Menu/Control Screen"
@onready var menu := $"Pause Menu"
@onready var resume_button := $"Pause Menu/Panel/Resume"


func _ready():
	visible = false

func open():
	visible = true
	get_tree().paused = true
	resume_button.grab_focus()

func close():
	visible = false
	get_tree().paused = false

func _on_resume_pressed():
	control_screen.visible = false
	close()

func _on_quit_pressed():
	get_tree().paused = false
	visible = false
	var ui := get_tree().root.get_node_or_null("UI")
	if ui:
		ui.visible = false
	control_screen.visible = false
	GameManager.can_pause = false
	GameManager.in_map = false
	get_tree().change_scene_to_file("res://Assets/UI/menu.tscn")

func _on_controls_pressed() -> void:
	control_screen.visible = !control_screen.visible
