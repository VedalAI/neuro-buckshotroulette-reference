class_name MpTurnExtension

static func GiveTurnPermissions_patch(instance: MP_RoundManager) -> void:
	_handle_player_turn(instance)

static func EndItemInteraction_patch(instance: MP_ItemInteraction) -> void:
	_handle_player_turn(instance.properties.intermediary.roundManager)

static func PickupShotgun_FirstPerson_postfix(instance: MP_ShotgunInteraction) -> void:
	var query = MpStrings.shoot_action_force_query

	var action_window := ActionWindow.new(instance)
	action_window.set_force(0 if OS.is_debug_build() else 10, query, "")
	action_window.add_action(ShootMp.new(action_window, instance))
	action_window.register()

static func _handle_player_turn(round: MP_RoundManager) -> void:
	var state = _get_turn_state(round.instance_handler)
	var query = MpStrings.player_turn_action_force_query

	var action_window := ActionWindow.new(round)
	action_window.set_force(0 if OS.is_debug_build() else 10, query, state)
	action_window.add_action(PickupShotgun.new(action_window, round.intermed.intermed_properties.shotgun))
	action_window.add_action(UseItemMp.new(action_window, round.intermed.intermed_properties.item_manager, true))
	action_window.register()

static func _get_turn_state(handler: MP_UserInstanceHandler) -> String:
	var result := ""

	for _player in handler.instance_property_array:
		var player: MP_UserInstanceProperties = _player
		if player.is_active:
			result += _generate_player_string(player)

	for _player in handler.instance_property_array:
		var player: MP_UserInstanceProperties = _player
		if not player.is_active:
			result += _generate_player_string(player)

	return result

static func _generate_player_string(player: MP_UserInstanceProperties) -> String:
	var health := player.health_current
	var items := _generate_items_string(MpUtil.get_player_items(player.item_manager))

	if player.is_active:
		return MpStrings.player_turn_action_force_state.format([health, items])
	else:
		return MpStrings.other_player_details.format([player.user_name, health, items])

static func _generate_items_string(items: Array[MP_PickupIndicator]) -> String:
	var dict := {}
	for item in items:
		if dict.has(item.itemName):
			dict[item.itemName]["count"] += 1
		else:
			dict[item.itemName] = {
				"name": item.tr(item.itemName).to_lower(),
				"description": item.tr(item.itemDescription).replace("\n", " ").to_lower(),
				"count": 1
			}

	var str_arr := []
	for key in dict.keys():
		var item_data = dict[key]
		str_arr.append("%dx %s (%s)" % [item_data["count"], item_data["name"], item_data["description"]])

	if str_arr.size() == 0:
		return "None"
	if str_arr.size() == 1:
		return str_arr[0]

	var string := ""
	for i in range(str_arr.size() - 2):
		string += str_arr[i]
		string += ", "
	string += str_arr[str_arr.size() - 2]
	string += " and "
	string += str_arr[str_arr.size() - 1]

	return string.replace("takes the edge off. regain 1 charge", "regain 1 health. cannot heal above starting health")
