extends Node2D

const MANTIS_P1_SCENE := preload("res://Test area/test player.tscn")
const MANTIS_P2_SCENE := preload("res://Test area/test player2.tscn")

const DRAGONFLY_P1_SCENE := preload("res://Script-Dragonfly/enemy.tscn")
const DRAGONFLY_P2_SCENE := preload("res://Script-Dragonfly/enemy2.tscn")

@onready var spawn1 = $Spawnpoint1
@onready var spawn2 = $Spawnpoint2

@onready var announcer_ready = $AnnouncerReady
@onready var announcer_fight = $AnnouncerFight
@onready var bg_music = $PlaceholderOST


func _ready():
	_spawn_players()
	_show_and_connect_ui()
	_run_announcer_sequence()


func _spawn_players():
	var p1_choice := Global.player1_character
	var p2_choice := Global.player2_character

	var same_character := (p1_choice == p2_choice)

	var p1_scene: PackedScene = _get_character_scene_for_slot(p1_choice, 1, false)
	var player1 = p1_scene.instantiate()
	add_child(player1)
	player1.global_position = spawn1.global_position
	player1.player_id = 1
	player1.name = p1_choice
	player1.add_to_group("player_1")

	var use_alt_for_p2 := same_character
	var p2_scene: PackedScene = _get_character_scene_for_slot(p2_choice, 2, use_alt_for_p2)
	var player2 = p2_scene.instantiate()
	add_child(player2)
	player2.global_position = spawn2.global_position
	player2.player_id = 2
	player2.name = p2_choice
	player2.add_to_group("player_2")
	
	GameManager.can_pause = true
	GameManager.in_map = true




func _get_character_scene_for_slot(character_name: String, player_id: int, use_alt: bool) -> PackedScene:
	match character_name:
		"Mantis":
			if use_alt and player_id == 2:
				return MANTIS_P2_SCENE
			else:
				return MANTIS_P1_SCENE

		"Dragonfly":
			if use_alt and player_id == 2:
				return DRAGONFLY_P2_SCENE
			else:
				return DRAGONFLY_P1_SCENE

		_:
			push_error("Unknown character: " + character_name)
			return MANTIS_P1_SCENE

func _show_and_connect_ui():
	if has_node("/root/UI"):
		var ui = get_node("/root/UI")
		ui.visible = true

		await get_tree().process_frame
		ui.connect_players()
	else:
		print("WARNING: /root/UI not found (is the UI autoload set up?)")

func _run_announcer_sequence():
	announcer_ready.play()
	await announcer_ready.finished

	announcer_fight.play()
	await announcer_fight.finished

	bg_music.play()
