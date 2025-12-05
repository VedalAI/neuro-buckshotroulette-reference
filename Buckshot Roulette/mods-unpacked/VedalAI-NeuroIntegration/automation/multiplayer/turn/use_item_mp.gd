class_name UseItemMp
extends NeuroAction

var _item_manager: MP_ItemManager
var _using_own_items: bool

func _init(action_window: ActionWindow, item_manager: MP_ItemManager, own: bool):
	super(action_window)
	_item_manager = item_manager
	_using_own_items = own

func _get_name() -> String:
	return "use_item"

func _get_description() -> String:
	return SpStrings.use_item_action_description if _using_own_items else MpStrings.steal_item_action_description

func _get_schema() -> Dictionary:
	return JsonUtils.wrap_schema({
		"item": {
			"enum": _get_usable_items().keys()
		}
	})

func _can_be_used() -> bool:
	return _get_usable_items().size() > 0

func _validate_action(data: IncomingData, state: Dictionary) -> ExecutionResult:
	var item: String = data.get_string("item")
	if not item:
		return ExecutionResult.failure(SpStrings.action_failed_missing_required_parameter.format(["item"]))

	var available_items := _get_usable_items()
	if not available_items.has(item):
		return ExecutionResult.failure(SpStrings.action_failed_invalid_parameter.format(["item"]))

	var pickupable := _get_usable_item_by_name(item)
	if not pickupable:
		return ExecutionResult.mod_failure(SpStrings.use_item_action_failed_could_not_find)

	state["item"] = pickupable
	return ExecutionResult.success()

func _execute_action(state: Dictionary) -> void:
	var item: MP_PickupIndicator = state["item"]
	var interaction: MP_InteractionBranch = item.get_parent().get_child(1)
	_item_manager.properties.item_interaction.InteractWithItemRequest(interaction.get_parent(), !_using_own_items)

func _get_usable_item_by_name(name: String) -> MP_PickupIndicator:
	return _get_usable_items().get(name, null)

func _get_usable_items() -> Dictionary:
	var items := {}

	if _using_own_items:
		var own_items := MpUtil.get_player_items(_item_manager)
		for pickup in own_items:
			if not pickup.interactionInvalid:
				var identifier := pickup.tr(pickup.itemName).to_lower()
				items[identifier] = pickup
	else:
		for _player in _item_manager.properties.intermediary.instance_handler.instance_property_array:
			var player: MP_UserInstanceProperties = _player
			if player.is_active:
				continue

			var player_name := player.user_name
			var others_items := MpUtil.get_player_items(player.item_manager)
			for pickup in others_items:
				if not pickup.interactionInvalid:
					var item_name := pickup.tr(pickup.itemName)
					var identifier := player_name + "'s " + item_name.to_lower()
					items[identifier] = pickup

	return items
