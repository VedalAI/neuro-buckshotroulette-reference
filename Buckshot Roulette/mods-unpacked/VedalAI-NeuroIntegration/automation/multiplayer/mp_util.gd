class_name MpUtil

static func get_player_items(item_manager: MP_ItemManager) -> Array[MP_PickupIndicator]:
	var items: Array[MP_PickupIndicator] = []

	var children: Array[Node3D] = item_manager.properties.user_inventory_instance_array
	for i in range(children.size()):
		var slot := children[i]
		if not slot:
			continue

		var item := slot.get_child(0) as MP_PickupIndicator
		if item:
			items.append(item)

	return items

static func get_lobbies() -> Array:
	var result := []

	var num_friends := Steam.getFriendCount()
	for i in range(num_friends):
		var friend := Steam.getFriendByIndex(i, Steam.FRIEND_FLAG_IMMEDIATE)

		var friend_game_played := Steam.getFriendGamePlayed(friend)
		if friend_game_played.get("id", 0) != GlobalSteam.appid:
			continue

		var lobby: int = friend_game_played.get("lobby", 0)
		var friend_name := Steam.getFriendPersonaName(friend)

		Log.info("Found Buckshot Roulette lobby from friend %s (%s)" % [friend_name, friend])

		result.append({"friend": friend_name, "lobby": lobby})

	return result
