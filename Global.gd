extends Node
# Default Spawn
var chosen_spawn = "Spawnpoint1"
var Chosen_Stage = PackedScene

func load_scene(target_scene: PackedScene):
	get_tree().change_scene_to_packed(target_scene)
 
