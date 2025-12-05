@tool
extends EditorPlugin


const AUTOLOAD_NAME: String = "Websocket"


func _enter_tree() -> void:
	# For safety, remove the previously malnamed singleton, if it still exists.
	if ProjectSettings.has_setting('autoload/neuro_sdk'):
		remove_autoload_singleton("neuro_sdk")

	add_autoload_singleton(AUTOLOAD_NAME, "res://addons/neuro-sdk/neuro_sdk.tscn")


func _exit_tree() -> void:
	if ProjectSettings.has_setting('autoload/neuro_sdk'):
		remove_autoload_singleton("neuro_sdk")

	remove_autoload_singleton(AUTOLOAD_NAME)
