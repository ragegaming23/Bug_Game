extends Node2D

# Spawnpoints
@onready var spawn1 = $Spawnpoint1
@onready var spawn2 = $Spawnpoint2

# Audio
@onready var announcer_ready = $AnnouncerReady
@onready var announcer_fight = $AnnouncerFight
@onready var bg_music = $PlaceholderOST

var player_id

func _ready():
	_spawn_players()
	_run_announcer_sequence()

func _spawn_players():
	# Player 1
	var p1_scene = _get_character_scene(Global.player1_character)
	var player1 = p1_scene.instantiate()
	add_child(player1)
	player1.global_position = spawn1.global_position
	player1.player_id = 1
	print("Spawned Player 1 as ", Global.player1_character)

	# Player 2
	var p2_scene = _get_character_scene(Global.player2_character)
	var player2 = p2_scene.instantiate()
	add_child(player2)
	player2.global_position = spawn2.global_position
	player2.player_id = 2
	print("Spawned Player 2 as ", Global.player2_character)


func _get_character_scene(character_name: String) -> PackedScene:
	match character_name:
		"Mantis":
			return preload("res://Test area/test player.tscn")
		"Dragonfly":
			return preload("res://Script-Dragonfly/enemy.tscn")
		_:
			push_error("Unknown character: " + character_name)
			return preload("res://Test area/test player.tscn")  # fallback


func _run_announcer_sequence():
	# Announcer: "Ready!"
	announcer_ready.play()
	await announcer_ready.finished

	# Announcer: "Fight!"
	announcer_fight.play()
	await announcer_fight.finished

	# Start background music
	bg_music.play()
