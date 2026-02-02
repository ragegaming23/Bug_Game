extends Node

var can_pause := false
var in_map := false

func _input(event):
	if event.is_action_pressed("pause_1"):
		if not can_pause or not in_map:
			return

		if get_tree().paused:
			PauseMenu.close()
		else:
			PauseMenu.open()
