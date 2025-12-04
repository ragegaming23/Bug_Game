extends Node2D

@onready var spawn1 = $Spawnpoint1
@onready var spawn2 = $Spawnpoint2

@onready var announcer_ready = $AnnouncerReady
@onready var announcer_fight = $AnnouncerFight
@onready var bg_music = $PlaceholderOST

func _ready():
	_spawn_players()
	_run_announcer_sequence()
	if has_node("/root/UI"):
		var ui = get_node("/root/UI")
		ui.visible = true
		
		await get_tree().process_frame
		ui.connect_players()

func _spawn_players():
	# Player 1
	var p1_scene = _get_character_scene(Global.player1_character)
	var player1 = p1_scene.instantiate()
	add_child(player1)
	player1.global_position = spawn1.global_position
	player1.player_id = 1
	player1.name = Global.player1_character
	player1.add_to_group("player_1")

	print("Spawned Player 1 as ", Global.player1_character)

	# Player 2
	var p2_scene = _get_character_scene(Global.player2_character)
	var player2 = p2_scene.instantiate()
	add_child(player2)
	player2.global_position = spawn2.global_position
	player2.player_id = 2
	player2.name = Global.player2_character
	player2.add_to_group("player_2")

	print("Spawned Player 2 as ", Global.player2_character)

	# Tell the UI to find these new players
	if Engine.has_singleton("UI"):
		UI.find_players()


func _get_character_scene(character_name: String) -> PackedScene:
	match character_name:
		"Mantis":
			return preload("res://Test area/test player.tscn")
		"Dragonfly":
			return preload("res://Script-Dragonfly/enemy.tscn")
		_:
			push_error("Unknown character: " + character_name)
			return preload("res://Test area/test player.tscn")


func _run_announcer_sequence():
	announcer_ready.play()
	await announcer_ready.finished

	announcer_fight.play()
	await announcer_fight.finished

	bg_music.play()
