class_name NeuroAction

var _action_window: ActionWindow

func _init(action_window: ActionWindow):
	_action_window = action_window

func get_name() -> String:
	return _get_name()

func can_be_used() -> bool:
	return _can_be_used()

func validate(data: IncomingData, state: Dictionary) -> ExecutionResult:
	if _action_window:
		return _action_window.result(_validate_action(data, state))
	return _validate_action(data, state)

func execute(state: Dictionary) -> void:
	_execute_action(state)

func get_ws_action() -> WsAction:
	return WsAction.new(_get_name(), _get_description(), _get_schema())

func _get_name() -> String:
	push_error("Action._get_name() is not implemented.")
	return ""

func _get_description() -> String:
	push_error("Action._get_description() is not implemented.")
	return ""

func _get_schema() -> Dictionary:
	push_error("Action._get_schema() is not implemented.")
	return {}

func _can_be_used() -> bool:
	return true

func _validate_action(_data: IncomingData, _state: Dictionary) -> ExecutionResult:
	push_error("Action._validate_action() is not implemented.")
	return ExecutionResult.mod_failure("Action._validate_action() is not implemented.")

func _execute_action(_state: Dictionary) -> void:
	push_error("Action._execute_action() is not implemented.")
