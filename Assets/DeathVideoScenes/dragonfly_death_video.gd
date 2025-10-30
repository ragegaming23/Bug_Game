extends Node2D

func _ready():
	var video = $VideoStreamPlayer
	await video.finished
	get_tree().change_scene_to_file("res://Assets/UI/win screen2.tscn")
