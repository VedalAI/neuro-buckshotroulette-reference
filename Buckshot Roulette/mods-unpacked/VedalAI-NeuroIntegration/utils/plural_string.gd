class_name PluralString

var _string: String
var _formats: Array[Callable]

func _init(string: String, formats: Array[Callable]):
	_string = string
	_formats = formats

func format(args: Array) -> String:
	return _string % _formats.map(func(f: Callable): return f.callv(args))
