class_name SpRoundStartExtension

static func Bootup_postfix(instance: HealthCounter) -> void:
	var health := instance.roundManager.health_player
	Websocket.send(Context.new(SpStrings.round_start_context.format([health]), true))

static func SetIntakeFocus_postfix(instance: ItemManager) -> void:
	instance.timer_steal_max = 60
	await instance.GrabItem()

static func GridParents_postfix(instance: ItemManager) -> void:
	var slots: Array[int] = []
	for i in range(instance.gridOccupiedArray.size()):
		if not instance.gridOccupiedArray[i]:
			slots.append(i)

	await instance.get_tree().create_timer(0.2).timeout

	var slot: int = slots.pick_random()
	instance.PlaceDownItem(slot)
