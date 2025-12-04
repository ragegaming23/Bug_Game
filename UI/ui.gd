extends CanvasLayer


# ============= PLAYER BARS ==============

@onready var players = {
	1: $P1_Bar,
	2: $P2_Bar
}

# ============= HEALTH BAR SETUP ==============

var health_values := [100,95,90,85,80,75,70,65,60,55,50,45,40,35,30,25,20,15,10,5,0]
var health_textures := {1:{}, 2:{}}

const P1_HEALTH_PATH := "res://Assets/Health Bar/New Health Bar/"
const P2_HEALTH_PATH := "res://Assets/Health Bar/New Health bar Mirrored/"

func _ready():
	print("UI loaded in:", get_tree().current_scene.name)
	
	visible = false   # HIDE AT START
	
	_load_health_bars()

	# Wait for players to spawn in map
	await get_tree().create_timer(0.3).timeout

	connect_players()

func connect_players():
	var p1 = get_tree().get_first_node_in_group("player_1")
	var p2 = get_tree().get_first_node_in_group("player_2")

	if p1:
		assign_player_insect(1, Global.player1_character)

		p1.health_changed.connect(func(current, max):
			set_player_health(1, int(float(current)/float(max) * 100))
		)

		p1.lives_changed.connect(func(lives):
			set_player_lives(1, lives)
		)

	if p2:
		assign_player_insect(2, Global.player2_character)

		p2.health_changed.connect(func(current, max):
			set_player_health(2, int(float(current)/float(max) * 100))
		)

		p2.lives_changed.connect(func(lives):
			set_player_lives(2, lives)
		)


func _on_player1_health_changed(current, max):
	set_player_health(1, int((float(current) / float(max)) * 100))

func _on_player2_health_changed(current, max):
	set_player_health(2, int((float(current) / float(max)) * 100))


func _on_player1_lives_changed(lives):
	set_player_lives(1, lives)

func _on_player2_lives_changed(lives):
	set_player_lives(2, lives)


func _load_health_bars():
	for value in health_values:
		var p1_path = P1_HEALTH_PATH + str(value) + ".png"
		var p2_path = P2_HEALTH_PATH + str(value) + ".png"

		health_textures[1][value] = load(p1_path)
		health_textures[2][value] = load(p2_path)


func set_player_health(player: int, percent: int):

	if !players.has(player):
		return

	percent = clamp(percent, 0, 100)

	var display_value := 0

	# Find closest step
	for v in health_values:
		if percent >= v:
			display_value = v
			break

	var bar = players[player].get_node("HealthTexture")

	if health_textures[player].has(display_value):
		bar.texture = health_textures[player][display_value]


# ============= LIFE SYSTEM ==============

func set_player_lives(player: int, lives: int):

	if !players.has(player):
		return

	var bar = players[player]

	var life1 = bar.get_node("Life1")
	var life2 = bar.get_node("Life2")

	life1.visible = lives >= 1
	life2.visible = lives >= 2

	_update_banner_from_lives(player, lives)


# ============= INSECT BANNER SYSTEM ==============

func assign_player_insect(player: int, insect_name: String):
	# Example: "Mantis" or "Dragonfly"

	if !players.has(player):
		return

	players[player].set_meta("insect", insect_name)

	_update_banner_from_lives(player, 2)


func _get_stage_from_lives(lives: int) -> String:
	match lives:
		2: return "full"
		1: return "damaged"
		0: return "destroyed"
		_: return "full"


func _update_banner_from_lives(player: int, lives: int):

	if !players.has(player):
		return

	if !players[player].has_meta("insect"):
		return

	var insect = players[player].get_meta("insect")
	var stage = _get_stage_from_lives(lives)

	var p_tag = "P" + str(player)

	var path = "res://Assets/Health Bar/banners/%s/%s_%s.png" % [insect, p_tag, stage]

	var banner = players[player].get_node("Banner")

	if ResourceLoader.exists(path):
		banner.texture = load(path)
	else:
		print("MISSING BANNER:", path)


# ============= DAMAGE HANDLING ==============

func take_damage(player: int, new_health: int, lives: int):

	set_player_health(player, new_health)

	if new_health <= 0:
		set_player_lives(player, lives)


func _input(event):

	if event.is_action_pressed("ui_accept"):
		set_player_health(1, 45)

	if event.is_action_pressed("ui_cancel"):
		set_player_lives(1, 1)
