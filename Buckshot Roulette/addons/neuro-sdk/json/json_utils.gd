class_name JsonUtils

static func wrap_schema(schema: Dictionary, add_required: bool = true) -> Dictionary:
	if add_required:
		return {
			"type": "object",
			"properties": schema,
			"required": schema.keys()
		}
	else:
		return {
			"type": "object",
			"properties": schema,
		}
