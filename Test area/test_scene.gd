extends Node2D


@onready var marker_2d: Marker2D = $Marker2D

	
func _on_player_respawned(player):
	player.global_position = marker_2d.global_position
	start_round()
	
func start_round():
	# Play "Ready"
	$Announcer.stream = preload("res://Voice Lines/Announcer/AnnouncerHall_Ready.wav")
	$Announcer.play()
	await $Announcer.finished # Wait until sound ends
	
	# Play "Fight"
	$Announcer.stream=preload("res://Voice Lines/Announcer/AnnouncerHall_Fight.ogg")
	$Announcer.play()
	await $Announcer.finished
	
