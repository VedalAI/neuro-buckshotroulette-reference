class_name ProperInput
extends Node

static var _instance: ProperInput
var _keys := {}

enum KeyState {
	KEYSTATE_UP,
	KEYSTATE_DOWN,
	KEYSTATE_HOLD
}

func _init():
	_instance = self

func _process(_delta: float) -> void:
	for key in _keys.keys():
		match _keys[key]:
			KeyState.KEYSTATE_UP:
				if Input.is_key_pressed(key):
					_keys[key] = KeyState.KEYSTATE_DOWN
			KeyState.KEYSTATE_DOWN:
				if Input.is_key_pressed(key):
					_keys[key] = KeyState.KEYSTATE_HOLD
				else:
					_keys[key] = KeyState.KEYSTATE_UP
			KeyState.KEYSTATE_HOLD:
				if not Input.is_key_pressed(key):
					_keys[key] = KeyState.KEYSTATE_UP

static func get_key_down(key: Key) -> bool:
	if not _instance._keys.has(key):
		_instance._keys[key] = KeyState.KEYSTATE_UP
		return false
	return _instance._keys[key] == KeyState.KEYSTATE_DOWN
