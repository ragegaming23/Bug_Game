extends Node2D


@onready var marker_2d: Marker2D = $Marker2D

	
	
		
func _on_player_respawned(player):
	player.global_position = marker_2d.global_position
