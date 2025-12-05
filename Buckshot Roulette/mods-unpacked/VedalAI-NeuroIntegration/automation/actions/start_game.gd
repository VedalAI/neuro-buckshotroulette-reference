class_name StartGame
extends NeuroAction

static var _instance: StartGame
var _lobby: LobbyController

static func register(lobby: LobbyController) -> void:
	if _instance:
		return

	_instance = StartGame.new(lobby)
	NeuroActionHandler.register_actions([_instance])

static func unregister() -> void:
	if not _instance:
		return

	NeuroActionHandler.unregister_actions([_instance])
	_instance = null

func _init(lobby: LobbyController):
	_lobby = lobby
	super(null)

func _get_name() -> String:
	return "start_game"

func _get_description() -> String:
	return MpStrings.start_game_action_description

func _get_schema() -> Dictionary:
	return JsonUtils.wrap_schema({}, false)

func _validate_action(data: IncomingData, state: Dictionary) -> ExecutionResult:
	return ExecutionResult.success()

func _execute_action(state: Dictionary) -> void:
	_lobby.StartGame()
	unregister()
