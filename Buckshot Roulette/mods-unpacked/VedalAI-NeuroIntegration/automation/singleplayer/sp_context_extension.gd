class_name SpContextExtension

static func SpawnShells_postfix(instance: ShellSpawner, lives: int, blanks: int) -> void:
	await instance.get_tree().create_timer(0.5).timeout
	Websocket.send(Context.new(SpStrings.shotgun_reload_context.format([lives, blanks])))

static func Shoot_patch(round_manager: RoundManager, shooter_player: bool, shot_player: bool, live: bool) -> void:
	var shooter := SpStrings.player_object if shooter_player else SpStrings.dealer_object
	var _shot_obj = SpStrings.player_object.to_lower() if shot_player else SpStrings.dealer_object.to_lower()
	var _shot_reflexive = SpStrings.player_pronoun_reflexive if shot_player else SpStrings.dealer_pronoun_reflexive
	var shot = _shot_reflexive if shooter_player == shot_player else _shot_obj
	var bullet = SpStrings.blank if not live else SpStrings.live_with_damage.format([round_manager.currentShotgunDamage])
	var _current_turn := SpStrings.player_pronoun_possessive if shooter_player else SpStrings.dealer_pronoun_possessive
	var turn_status := SpStrings.continue_turn.format([_current_turn]) if shooter_player == shot_player and not live else SpStrings.end_turn.format([_current_turn])
	var context = SpStrings.shotgun_shot_context.format([shooter, shot, bullet, turn_status])
	Websocket.send(Context.new(context, false))

static func InteractWith_prefix(instance: ItemInteraction, item_name: String) -> void:
	if item_name == "magnifying glass":
		await instance.get_tree().create_timer(2.5).timeout
		var bullet = SpStrings.live if instance.roundManager.shellSpawner.sequenceArray[0] == "live" else SpStrings.blank
		var context = SpStrings.magnifying_glass_context.format([bullet])
		Websocket.send(Context.new(context, false))

static func SendDialogue_patch(message: String) -> void:
	var context = SpStrings.burner_phone_context.format([message.replace("\n", " ")])
	Websocket.send(Context.new(context, true))

static func OutOfHealth_prefix(is_player: bool) -> void:
	var context := SpStrings.player_died_context if is_player else SpStrings.dealer_died_context
	Websocket.send(Context.new(context, false))

static func UseMedicine_patch(did_heal: bool) -> void:
	var desc = SpStrings.medicine_good_player if did_heal else SpStrings.medicine_bad_player
	var context = SpStrings.medicine_context.format([desc])
	Websocket.send(Context.new(context, false))

static func BeerEjection_player_prefix(is_live: bool) -> void:
	var shell = SpStrings.live if is_live else SpStrings.blank
	var context = SpStrings.beer_context.format([shell])
	Websocket.send(Context.new(context, false))

static func PickupItemFromTable_patch(what: String) -> void:
	var item_desc: String
	match what:
		"handsaw":
			item_desc = SpStrings.saw_description
		"magnifying glass":
			item_desc = SpStrings.magnifying_glass_description
		"handcuffs":
			item_desc = SpStrings.handcuffs_description
		"cigarettes":
			item_desc = SpStrings.cigar_description
		"beer":
			return # This context is sent somewhere else
		"expired medicine":
			return # This context is sent somewhere else
		"inverter":
			item_desc = SpStrings.inverter_description
		"burner phone":
			return # We don't care about phones
		"adrenaline":
			item_desc = SpStrings.adrenaline_description

	var context = SpStrings.dealer_used_item_context.format([what, item_desc])
	Websocket.send(Context.new(context, false))

static func UseMedicine_Dealer_patch(did_heal: bool) -> void:
	var desc = SpStrings.medicine_description_good if did_heal else SpStrings.medicine_description_bad
	var context = SpStrings.dealer_used_item_context.format(["expired medicine", desc])
	Websocket.send(Context.new(context, false))

static func BeerEjection_dealer_prefix(is_live: bool) -> void:
	var shell = SpStrings.live if is_live else SpStrings.blank
	var item_desc = SpStrings.beer_description.format([shell])
	var context = SpStrings.dealer_used_item_context.format(["beer", item_desc])
	Websocket.send(Context.new(context, false))

static func BeginPlayerTurn_prefix(instance: RoundManager) -> void:
	if instance.playerCuffed and !instance.playerAboutToBreakFree:
		var context = SpStrings.turn_skipped_context.format([SpStrings.player_pronoun_possessive])
		Websocket.send(Context.new(context, true))

static func DealerCheckHandCuffs_prefix(instance: DealerIntelligence) -> void:
	if !instance.dealerAboutToBreakFree:
		var context = SpStrings.turn_skipped_context.format([SpStrings.dealer_object_possessive])
		Websocket.send(Context.new(context, true))

static func RevivalBathroomStart_patch() -> void:
	Websocket.send(Context.new(SpStrings.smoker_guy_revive_context, false))

static func Heaven__ready_postfix(instance: Heaven) -> void:
	Websocket.send(Context.new(SpStrings.true_death_context, false))

static func BeginEnding_patch(cash: String) -> void:
	var context := SpStrings.game_win_context.format([cash])
	Websocket.send(Context.new(context, false))
