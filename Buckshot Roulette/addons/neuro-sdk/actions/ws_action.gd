class_name WsAction

var name: String
var description: String
var schema

func _init(name_: String, description_: String, schema_) -> void:
	name = name_
	description = description_
	schema = schema_

func to_dict() -> Dictionary:
	return {
		"name": name,
		"description": description,
		"schema": schema
	}
