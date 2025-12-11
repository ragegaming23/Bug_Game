extends TextureButton

@export var use_hover_as_focus: bool = true

var _normal_tex: Texture2D
var _hover_tex: Texture2D

func _ready() -> void:
	focus_mode = Control.FOCUS_ALL

	_normal_tex = texture_normal
	_hover_tex = texture_hover

	focus_entered.connect(_on_focus_entered)
	focus_exited.connect(_on_focus_exited)


func _on_focus_entered() -> void:
	if use_hover_as_focus and _hover_tex:
		texture_normal = _hover_tex


func _on_focus_exited() -> void:
	if _normal_tex:
		texture_normal = _normal_tex
