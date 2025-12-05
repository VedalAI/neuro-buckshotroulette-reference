class_name Action
extends IncomingMessage

func _can_handle(command: String) -> bool:
	return command == "action"

func _validate(_command: String, message_data: IncomingData, state: Dictionary) -> ExecutionResult:
	if message_data == null:
		return ExecutionResult.vedal_failure(Strings.action_failed_no_data)

	var action_id := message_data.get_string("id");
	if not action_id:
		return ExecutionResult.vedal_failure(Strings.action_failed_no_id)

	state["_action_id"] = action_id;

	var action_name := message_data.get_string("name")
	var action_stringified_data := message_data.get_string("data", "{}")

	if action_name == null or action_name == "":
		return ExecutionResult.vedal_failure(Strings.action_failed_no_name)

	var action := NeuroActionHandler.get_action(action_name)
	if action == null:
		if NeuroActionHandler.is_recently_unregistered(action_name):
			return ExecutionResult.failure(Strings.action_failed_unregistered)
		return ExecutionResult.failure(Strings.action_failed_unknown_action.format([action_name]))

	state["_action_instance"] = action;

	var json := JSON.new()
	var error := json.parse(action_stringified_data)
	if error != OK:
		return ExecutionResult.failure(Strings.action_failed_invalid_json)

	if typeof(json.data) != TYPE_DICTIONARY:
		push_error("Action data can only be a dictionary. Other respones are not permitted for the API implementation in Godot.")
		return ExecutionResult.failure(Strings.action_failed_invalid_json)

	var action_data := IncomingData.new(json.data)

	var result := action.validate(action_data, state)
	return result

func _report_result(state: Dictionary, result: ExecutionResult) -> void:
	var id = state.get("_action_id", null);
	if id == null:
		push_error("Action.report_result received no action id. It probably could not be parsed in the action. Received result: %s" % [result.message])
		return

	Websocket.send(ActionResult.new(id, result))

func _execute(state: Dictionary) -> void:
	var action: NeuroAction = state["_action_instance"]
	action.execute(state)
