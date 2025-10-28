extends Control



# Called when the node enters the scene tree for the first time.
func _ready():
	$"BoxContainer/PrayingMantis".grab_focus()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	print("Button pressed, trying to load loading screen…")
	get_tree().change_scene_to_file("res://Assets/UI/Loading Screen/LoadingScreen.tscn")
	
