class_name MpItemExtension

static func BeginItemStealing_postfix(instance: MP_ItemStealing) -> void:
	var query := MpStrings.steal_item_action_force_query

	var action_window := ActionWindow.new(instance)
	action_window.set_force(0 if OS.is_debug_build() else 3, query, "")
	action_window.add_action(UseItemMp.new(action_window, instance.properties.item_manager, false))
	action_window.register()

static func BootupFinished_postfix(instance: MP_Jammer) -> void:
	var query := MpStrings.skip_turn_action_force_query

	var action_window := ActionWindow.new(instance)
	action_window.set_force(0 if OS.is_debug_build() else 3, query, "")
	action_window.add_action(SkipTurn.new(action_window, instance))
	action_window.register()
