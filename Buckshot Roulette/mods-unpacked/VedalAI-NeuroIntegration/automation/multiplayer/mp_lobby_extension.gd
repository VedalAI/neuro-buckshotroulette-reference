class_name MpLobbyExtension

static func ready_postfix(instance: MP_LobbyUI) -> void:
	var args: PackedStringArray = OS.get_cmdline_args()
	await instance.get_tree().create_timer(7).timeout
	if args.has("--host"):
		instance.lobby_manager.CreateLobby()
	else:
		for arg in args:
			if arg.begins_with("--join="):
				var join_name := arg.substr("--join=".length())
				_join_lobby(join_name)
				break

static func _join_lobby(friend_name: String) -> void:
	if not GlobalSteam.ONLINE:
		return

	if not friend_name:
		return

	var lobbies := MpUtil.get_lobbies()
	if lobbies.size() == 0:
		return

	var maybe_closest = IHateAlgorithms.get_closest_by_levenshtein_distance(lobbies, func(lobby: Dictionary) -> String: return lobby["friend"], friend_name, 3)
	if not maybe_closest:
		return

	var closest: Dictionary = maybe_closest
	Steam.joinLobby(closest["lobby"])
