extends Camera2D


@export var player1: CharacterBody2D
@export var player2: CharacterBody2D
@export var min_zoom = 1.0
@export var max_zoom = .8
@export var zoom_multiplier = 1 # Adjust as needed to fit the screen
@export var min_distance_for_zoom = 750.0
@export var camera_limits: Rect2 # Define the level boundaries in the inspector

func _ready():
	 # Ensure players are assigned in the inspector or fetched programmatically
	if player1 == null or player2 == null:
		print("Players not assigned to camera script!")
		set_process(false)
		return

	# Set camera limits
	limit_left = int(camera_limits.position.x)
	limit_top = int(camera_limits.position.y)
	limit_right = int(camera_limits.end.x)
	limit_bottom = int(camera_limits.end.y)
	# Enable limit smoothing for smoother boundary stops
	#limit_smoothing_enabled = true

func _physics_process(_delta):
	if player1 and player2:
		# 1. Calculate the midpoint position
		var center_point = (player1.global_position + player2.global_position) / 2.0
		global_position = center_point

		# 2. Calculate the distance between players
	var distance = player1.global_position.distance_to(player2.global_position)

		# 3. Adjust zoom based on distance
		# A simple linear formula: greater distance -> more zoom out (smaller value)
		# You may need to tune the values (min_zoom, max_zoom, zoom_multiplier) 
		# to fit your specific game's screen size and desired feel.
	var target_zoom = clamp(distance * zoom_multiplier, min_zoom, max_zoom)

		# Optionally, only zoom if the distance is significant
	if distance > min_distance_for_zoom:
		zoom = Vector2(target_zoom, target_zoom)
	else:
			# Keep a default zoom level if players are close
		zoom = Vector2(min_zoom, min_zoom)

		# You can also use move_toward for non-smoothing camera nodes
		# global_position = global_position.move_toward(center_point, speed * delta)
