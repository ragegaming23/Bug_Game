extends Node2D


@onready var announcer_ready = $AnnouncerReady
@onready var announcer_fight = $AnnouncerFight
@onready var bg_music = $PlaceholderOST

func _ready():
	var spawn_name = Global.chosen_spawn
	var spawn_points = $Spawnpoints
	var spawn_point = spawn_points.get_node(spawn_name)
	var player = $"Test player"
	player.global_position = spawn_point.global_position
	
	announcer_ready.play()
	await announcer_ready.finished

	announcer_fight.play()
	await announcer_fight.finished
	#Start background music
	bg_music.play()
