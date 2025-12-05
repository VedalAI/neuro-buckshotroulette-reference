class_name CursorVisibility
extends Node

static var _cursor_visible := false

static func SetCursor_prefix() -> bool:
	return _cursor_visible

func _process(_delta: float) -> void:
	if ProperInput.get_key_down(KEY_U):
		_cursor_visible = !_cursor_visible
		Log.info("Cursor visibility toggled to " + str(_cursor_visible))
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE if _cursor_visible else Input.MOUSE_MODE_HIDDEN)
