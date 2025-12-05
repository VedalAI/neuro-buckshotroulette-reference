class_name ExecutionResult

var successful: bool
var message: String

func _init(success_: bool, message_) -> void:
	if message_ == null:
		message_ = ""

	successful = success_
	message = message_

static func success(message_ = null) -> ExecutionResult:
	return ExecutionResult.new(true, message_)

static func failure(message_: String) -> ExecutionResult:
	return ExecutionResult.new(false, message_)

static func vedal_failure(message_: String) -> ExecutionResult:
	return failure(message_ + Strings.action_failed_vedal_fault_suffix)

static func mod_failure(message_: String) -> ExecutionResult:
	return failure(message_ + Strings.action_failed_mod_fault_suffix)
