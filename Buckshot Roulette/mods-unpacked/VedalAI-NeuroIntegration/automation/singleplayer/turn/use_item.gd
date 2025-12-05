class_name UseItem
extends NeuroAction

var _item_manager: ItemManager
var _using_player_items: bool

func _init(action_window: ActionWindow, item_manager: ItemManager, player: bool):
	super(action_window)
	_item_manager = item_manager
	_using_player_items = player

func _get_name() -> String:
	return "use_item"

func _get_description() -> String:
	return SpStrings.use_item_action_description

func _get_schema() -> Dictionary:
	return JsonUtils.wrap_schema({
		"item": {
			"enum": _get_usable_item_names()
		}
	})

func _can_be_used() -> bool:
	return _get_usable_item_names().size() > 0

func _validate_action(data: IncomingData, state: Dictionary) -> ExecutionResult:
	var item: String = data.get_string("item")
	if not item:
		return ExecutionResult.failure(SpStrings.action_failed_missing_required_parameter.format(["item"]))

	var available_items := _get_usable_item_names()
	if not available_items.has(item):
		return ExecutionResult.failure(SpStrings.action_failed_invalid_parameter.format(["item"]))

	var pickupable := _get_usable_item_by_name(item)
	if not pickupable:
		return ExecutionResult.mod_failure(SpStrings.use_item_action_failed_could_not_find)

	state["item"] = pickupable
	return ExecutionResult.success()

func _execute_action(state: Dictionary) -> void:
	var item: PickupIndicator = state["item"]
	var interaction: InteractionBranch = item.get_parent().get_child(1)
	_item_manager.interaction.PickupItemFromTable(item.get_parent(), interaction.itemName)

func _get_usable_item_names() -> Array[String]:
	var result: Array[String] = []
	result.assign(_get_target_usable_items().map(func(item: PickupIndicator) -> String: return item.tr(item.itemName).to_lower()))
	return result

func _get_usable_item_by_name(name: String) -> PickupIndicator:
	var items := _get_target_usable_items()
	items.shuffle()
	for item in items:
		if item.tr(item.itemName).to_lower() == name.to_lower():
			return item
	return null

func _get_target_usable_items() -> Array[PickupIndicator]:
	var all_items: Array[PickupIndicator]
	var usable_items: Array[PickupIndicator]
	if _using_player_items:
		all_items = SpUtil.get_player_items(_item_manager)
	else:
		all_items = SpUtil.get_dealer_items(_item_manager)

	usable_items.assign(all_items.filter(func(item: PickupIndicator) -> bool: return not item.interactionInvalid))
	return usable_items
