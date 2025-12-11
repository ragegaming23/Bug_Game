extends Node

var Chosen_Stage = PackedScene

func load_scene(target_scene: PackedScene):
	get_tree().change_scene_to_packed(target_scene)

var player1_character: String = "Mantis"
var player2_character: String = "Dragonfly"

var spawn_points = {
	1: "Spawnpoint1",
	2: "Spawnpoint2"
}

var last_winner_player_id: int = 0
var last_winner_insect: String = ""
