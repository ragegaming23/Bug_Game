extends TextureButton

@export var click_sound: AudioStream

func _ready():
	pressed.connect(_play_click)

func _play_click():
	if click_sound:
		var player = $AudioStreamPlayer
		player.stream = click_sound
		player.play()
