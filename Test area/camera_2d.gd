extends Camera2D

@export var player1: CharacterBody2D
@export var player2: CharacterBody2D
@export var min_zoom = 1.0
@export var max_zoom = .8
@export var zoom_multiplier = 1
@export var min_distance_for_zoom = 750.0
@export var camera_limits: Rect2

func _ready():
	if player1 == null or player2 == null:
		print("Players not assigned to camera script!")
		set_process(false)
		return

	limit_left = int(camera_limits.position.x)
	limit_top = int(camera_limits.position.y)
	limit_right = int(camera_limits.end.x)
	limit_bottom = int(camera_limits.end.y)

func _physics_process(_delta):
	# Prevent null crashes
	if player1 == null or player2 == null:
		return

	# 1. Midpoint tracking
	var center_point = (player1.global_position + player2.global_position) / 2.0
	global_position = center_point

	# 2. Distance between players
	var distance = player1.global_position.distance_to(player2.global_position)

	# 3. Zoom control
	var target_zoom = clamp(distance * zoom_multiplier, min_zoom, max_zoom)

	if distance > min_distance_for_zoom:
		zoom = Vector2(target_zoom, target_zoom)
	else:
		zoom = Vector2(min_zoom, min_zoom)
