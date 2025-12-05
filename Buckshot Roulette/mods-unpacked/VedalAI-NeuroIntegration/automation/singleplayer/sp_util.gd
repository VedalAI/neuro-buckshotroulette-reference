class_name SpUtil

static func get_player_items(item_manager: ItemManager) -> Array[PickupIndicator]:
	var items: Array[PickupIndicator] = []
	items.assign(_get_all_items(item_manager).filter(func(item: PickupIndicator) -> bool: return !item.isDealerItem))
	return items

static func get_dealer_items(item_manager: ItemManager) -> Array[PickupIndicator]:
	var items: Array[PickupIndicator] = []
	items.assign(_get_all_items(item_manager).filter(func(item: PickupIndicator) -> bool: return item.isDealerItem))
	return items

static func _get_all_items(item_manager: ItemManager) -> Array[PickupIndicator]:
	var items: Array[PickupIndicator] = []

	var children: Array[Node] = item_manager.itemSpawnParent.get_children()
	for i in range(children.size()):
		var item := children[i].get_child(0) as PickupIndicator
		if item != null:
			items.append(item)

	return items
