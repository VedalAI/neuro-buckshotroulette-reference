class_name JoinFriendLobby
extends NeuroAction

static var _instance: JoinFriendLobby

static func register() -> void:
	if _instance:
		Log.info("JoinFriendLobby already exists, not registering again")
		return

	_instance = JoinFriendLobby.new()
	NeuroActionHandler.register_actions([_instance])

static func unregister() -> void:
	if not _instance:
		Log.info("JoinFriendLobby is already not registered")
		return

	NeuroActionHandler.unregister_actions([_instance])
	_instance = null

func _init():
	super(null)

func _get_name() -> String:
	return "join_friend_lobby"

func _get_description() -> String:
	return MpStrings.join_friend_lobby_action_description

func _get_schema() -> Dictionary:
	return JsonUtils.wrap_schema({
		"friend_name": {
			"type": "string"
		}
	}, false)

func _validate_action(data: IncomingData, state: Dictionary) -> ExecutionResult:
	if not GlobalSteam.ONLINE:
		return ExecutionResult.vedal_failure(MpStrings.join_friend_lobby_action_failed_steam_uninitialized)

	var lobbies := MpUtil.get_lobbies()
	if lobbies.size() == 0:
		return ExecutionResult.failure(MpStrings.join_friend_lobby_action_failed_no_lobbies)

	var friend_name := data.get_string("friend_name")
	if not friend_name:
		var random_lobby: Dictionary = lobbies.pick_random()
		state["lobby"] = random_lobby["lobby"]
		return ExecutionResult.success()

	var maybe_closest = IHateAlgorithms.get_closest_by_levenshtein_distance(lobbies, func(lobby: Dictionary) -> String: return lobby["friend"], friend_name, 3)
	if not maybe_closest:
		return ExecutionResult.failure(MpStrings.join_friend_lobby_action_failed_invalid_friend)

	var closest: Dictionary = maybe_closest
	state["lobby"] = closest["lobby"]
	return ExecutionResult.success()

func _execute_action(state: Dictionary) -> void:
	Steam.joinLobby(state["lobby"])
