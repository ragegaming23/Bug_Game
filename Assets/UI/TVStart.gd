extends TextureButton

@export var use_hover_as_focus: bool = true

var _normal_tex: Texture2D
var _hover_tex: Texture2D

@onready var hover_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var click_player: AudioStreamPlayer = $AudioStreamPlayer2

func _ready():
	focus_mode = Control.FOCUS_ALL
	_normal_tex = texture_normal
	_hover_tex = texture_hover
	mouse_entered.connect(_on_mouse_entered)
	focus_entered.connect(_on_focus_entered)
	focus_exited.connect(_on_focus_exited)


func _on_mouse_entered() -> void:
	_play_hover()
	
func _gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		if click_player:
			click_player.stop()
			click_player.play()


func _on_focus_entered() -> void:
	if use_hover_as_focus and _hover_tex:
		texture_normal = _hover_tex

	_play_hover()

func _on_focus_exited() -> void:
	if _normal_tex:
		texture_normal = _normal_tex

func _unhandled_input(event: InputEvent) -> void:
	if not has_focus():
		return

	if event.is_action_pressed("ui_accept"):
		if click_player:
			click_player.stop()
			click_player.play()

func _play_hover():
	if hover_player and not hover_player.playing:
		hover_player.play()
