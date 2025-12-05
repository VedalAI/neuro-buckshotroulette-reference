class_name FormatString

var _string: String

func _init(string: String):
	_string = string

func format(args: Array) -> String:
	return _string % args
