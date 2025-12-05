class_name SpIntroExtension

static func ready_prefix(instance: IntroManager) -> void:
	var unlocked = FileAccess.file_exists(instance.unlocker.savepath)
	if not unlocked: 
		instance.unlocker.UnlockMode()

static func MainBathroomStart_prefix(instance: IntroManager) -> void:
	if Input.is_key_pressed(KEY_S):
		return

	if OS.is_debug_build():
		await instance.get_tree().create_timer(0.5).timeout
		instance.endlessmode.SetupEndless()
		instance.Interaction_BackroomDoor()
		return

	await instance.get_tree().create_timer(1.5).timeout

	if instance.allowingPills:
		instance.Interaction_PillBottle()
	else:
		instance.Interaction_BathroomDoor()

static func RevivalBathroomStart_postfix(instance: IntroManager) -> void:
	instance.Interaction_BathroomDoor()

static func Interaction_PillBottle_prefix(instance: IntroManager) -> void:
	instance.SelectedPill(true)

static func SelectedPill_postfix(instance: IntroManager) -> void:
	instance.Interaction_BathroomDoor()

static func Interaction_BathroomDoor_prefix(instance: IntroManager) -> void:
	await instance.get_tree().create_timer(4.2, false).timeout
	instance.Interaction_BackroomDoor()

static func AwaitPickup_postfix(instance: Signature) -> void:
	instance.PickUpWaiver()

static func PickUpWaiver_postfix(instance: Signature) -> void:
	Websocket.send(Context.new(SpStrings.rules_context, true))

	var action_window := ActionWindow.new(instance)
	action_window.set_force(10 if !OS.is_debug_build() else 0, SpStrings.choose_name_action_force_query, "")
	action_window.add_action(ChooseName.new(action_window, instance))
	action_window.register()
