extends Control

@export var Stage_1 : PackedScene
@export var Stage_2 : PackedScene
@export var Stage_3 : PackedScene
@export var Stage_4 : PackedScene
@export var Stage_5 : PackedScene
# Called when the node enters the scene tree for the first time.
func _ready():
	$BoxContainer/Stage_1.grab_focus()



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


#func _on_button_pressed() -> void:
	#get_tree().change_scene_to_file("res://Assets/UI/CharacterSelection/character_selection.tscn")
	#Global.chosen_spawn = "Spawnpoint1"
	#LocalNetwork.start_server()

func _on_stage_1_pressed() -> void:
	get_tree().change_scene_to_file("res://Assets/UI/CharacterSelection/character_selection.tscn")
	Global.Chosen_Stage = Stage_1
	LocalNetwork.start_server()


func _on_stage_2_pressed() -> void:
	get_tree().change_scene_to_file("res://Assets/UI/CharacterSelection/character_selection.tscn")
	Global.Chosen_Stage = Stage_2
	LocalNetwork.start_server()

func _on_stage_3_pressed() -> void:
	get_tree().change_scene_to_file("res://Assets/UI/CharacterSelection/character_selection.tscn")
	Global.Chosen_Stage = Stage_3
	LocalNetwork.start_server()


func _on_stage_4_pressed() -> void:
	get_tree().change_scene_to_file("res://Assets/UI/CharacterSelection/character_selection.tscn")
	Global.Chosen_Stage = Stage_4
	LocalNetwork.start_server()

func _on_stage_5_pressed() -> void:
	get_tree().change_scene_to_file("res://Assets/UI/CharacterSelection/character_selection.tscn")
	Global.Chosen_Stage = Stage_5
	LocalNetwork.start_server()
