class_name GameLeaveLobby
extends IncomingMessage

func _can_handle(command: String) -> bool:
	return command == "game/leave_lobby"

func _validate(_command: String, _data: IncomingData, _state: Dictionary) -> ExecutionResult:
	return ExecutionResult.success()

func _report_result(_state: Dictionary, _result: ExecutionResult) -> void:
	pass

func _execute(_state: Dictionary) -> void:
	var lobby_ui = get_node("/root/mp_lobby/standalone managers/lobby manager")
	if lobby_ui:
		lobby_ui.leave_lobby()

	var ingame_ui = get_node("/root/mp_main/standalone managers/interactions/interaction intermediary")
	if ingame_ui:
		GlobalVariables.disband_lobby_after_exiting_main_scene = true
		ingame_ui.ExitGame()
