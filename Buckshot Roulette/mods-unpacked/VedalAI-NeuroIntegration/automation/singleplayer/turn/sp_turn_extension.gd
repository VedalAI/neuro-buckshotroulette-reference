class_name SpTurnExtension

static func LoadShells_postfix(instance: ShellLoader) -> void:
	_handle_player_turn(instance.roundManager)

static func BeginPlayerTurn_postfix(instance: RoundManager) -> void:
	_handle_player_turn(instance)

static func EnablePermissions_postfix(instance: ItemInteraction) -> void:
	if not instance.stealing_fs:
		_handle_player_turn(instance.roundManager)

static func _handle_player_turn(round: RoundManager) -> void:
	var player_health = round.health_player
	var player_items: String = generate_items_string(SpUtil.get_player_items(round.itemManager))
	var dealer_health = round.health_opponent
	var dealer_items: String = generate_items_string(SpUtil.get_dealer_items(round.itemManager))
	var state = SpStrings.player_turn_action_force_state.format([player_health, player_items, dealer_health, dealer_items])
	var query = SpStrings.player_turn_action_force_query

	var action_window := ActionWindow.new(round)
	action_window.set_force(0, query, state)
	action_window.add_action(Shoot.new(action_window, round.dealerAI.shotgunShooting))
	action_window.add_action(UseItem.new(action_window, round.itemManager, true))
	action_window.register()

static func generate_items_string(items: Array[PickupIndicator]) -> String:
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

	return string.replace("dealer skips the next turn", "opponent skips the next turn").replace("takes the edge off. regain 1 charge", "regain 1 health. cannot heal above starting health").replace("50% chance to regain 2 charges. if not, lose 1 charge", "50% chance to regain 2 health. if not, lose 1 health. cannot heal above starting health")
