class_name MpRoundStartExtension

static func BootupDisplay_Health_patch(instance: MP_HealthCounter) -> void:
	if not instance.properties.is_active:
		return

	var health := instance.properties.health_on_round_start
	Websocket.send(Context.new(MpStrings.round_start_context.format([health]), true))

static func SetIntakeCollider_postfix(instance: MP_ItemManager) -> void:
	await instance.get_tree().create_timer(0.5).timeout
	instance.GrabItemRequest()

static func SetGridColliders_postfix(instance: MP_ItemManager) -> void:
	var slots: Array[int] = []
	for i in range(instance.intbranch_grid_colliders.size()):
		if instance.intbranch_grid_colliders[i].interactionAllowed:
			slots.append(i)

	await instance.get_tree().create_timer(0.2).timeout

	var slot: int = slots.pick_random()
	instance.PlaceItemRequest(slot)
