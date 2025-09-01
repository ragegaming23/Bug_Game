extends Node2D


@onready var marker_2d: Marker2D = $Marker2D

	
func _on_player_respawned(player):
	player.global_position = marker_2d.global_position

@onready var announcer_ready = $AnnouncerReady
@onready var announcer_fight = $AnnouncerFight
@onready var bg_music = $PlaceholderOST

func _ready():
	announcer_ready.play()
	await announcer_ready.finished

	announcer_fight.play()
	await announcer_fight.finished
	#Start background music
	bg_music.play()
