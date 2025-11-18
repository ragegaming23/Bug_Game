extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var spawn_name = Global.chosen_spawn
	var spawn_points = $Spawnpoints
	var spawn_point = spawn_points.get_node(spawn_name)
	var player = $"Test player" #"player_%s" %[player_id]
	player.global_position = spawn_point.global_position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
