class_name WsMessage


var command: String
var data: Dictionary
var game: String


func _init(_command: String, _data: Dictionary, _game: String):
	command = _command
	data = _data
	game = _game


func get_data() -> Dictionary:
	if data.is_empty():
		return {
			"command": command,
			"game": game
		}

	return {
		"command": command,
		"game": game,
		"data": data
	}
