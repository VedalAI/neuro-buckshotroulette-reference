class_name SpAdrenalineExtension

static func SetupItemSteal_postfix(instance: ItemManager):
	var player_health = instance.roundManager.health_player
	var player_items: String = SpTurnExtension.generate_items_string(SpUtil.get_player_items(instance.roundManager.itemManager))
	var dealer_health = instance.roundManager.health_opponent
	var dealer_items: String = SpTurnExtension.generate_items_string(SpUtil.get_dealer_items(instance.roundManager.itemManager))
	var state = SpStrings.player_turn_action_force_state.format([player_health, player_items, dealer_health, dealer_items])
	var query := SpStrings.steal_item_action_force_query

	var action_window := ActionWindow.new(instance)
	action_window.set_force(0, query, state)
	action_window.add_action(UseItem.new(action_window, instance, false))
	action_window.register()
