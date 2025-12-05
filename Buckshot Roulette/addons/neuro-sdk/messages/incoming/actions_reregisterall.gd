class_name ActionsReregisterAll
extends IncomingMessage

func _can_handle(command: String) -> bool:
	return command == "actions/reregister_all"

func _validate(_command: String, _data: IncomingData, _state: Dictionary) -> ExecutionResult:
	return ExecutionResult.success()

func _report_result(_state: Dictionary, _result: ExecutionResult) -> void:
	pass

func _execute(_state: Dictionary) -> void:
	NeuroActionHandler.resend_registered_actions()
