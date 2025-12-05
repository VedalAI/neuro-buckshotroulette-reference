class_name MpContextExtension

static func LoadShotgun_patch(instance: MP_RoundManager) -> void:
	await instance.get_tree().create_timer(2).timeout

	var sequence: Array = instance.shell_loader.game_state.MAIN_active_sequence_dict.sequence_visible
	var lives: int = sequence.filter(func(type: String) -> bool: return type == "live").size()
	var blanks: int = sequence.filter(func(type: String) -> bool: return type == "blank").size()

	Websocket.send(Context.new(SpStrings.shotgun_reload_context.format([lives, blanks])))

static func ShootingOutcome_patch(instance: MP_ShotgunInteraction, shooter_player: MP_UserInstanceProperties, shot_player: MP_UserInstanceProperties, live: bool) -> void:
	var shooter := SpStrings.player_object if shooter_player.is_active else shooter_player.user_name
	var _shot_obj = SpStrings.player_object.to_lower() if shot_player.is_active else shot_player.user_name
	var _shot_reflexive = SpStrings.player_pronoun_reflexive if shot_player.is_active else SpStrings.dealer_pronoun_reflexive
	var shot = _shot_reflexive if shooter_player.socket_number == shot_player.socket_number else _shot_obj
	var bullet = SpStrings.blank if not live else SpStrings.live_with_damage.format([instance.active_shooter_shotgun_damage])
	var _current_turn := SpStrings.player_pronoun_possessive if shooter_player.is_active else SpStrings.dealer_pronoun_possessive
	var turn_status := SpStrings.continue_turn.format([_current_turn]) if shooter_player.socket_number == shot_player.socket_number and not live else SpStrings.end_turn.format([_current_turn])
	var context = SpStrings.shotgun_shot_context.format([shooter, shot, bullet, turn_status])
	Websocket.send(Context.new(context, false))

static func ChangeGameStateWithItem_patch(instance: MP_ItemInteraction, type: String) -> void:
	if not instance.properties.is_active:
		return

	await instance.get_tree().create_timer(2.5).timeout
	var bullet = SpStrings.live if type == "live" else SpStrings.blank
	var context = SpStrings.magnifying_glass_context.format([bullet])
	Websocket.send(Context.new(context, false))

static func GetBurnerPhoneString_postfix(message: String) -> void:
	var context = MpStrings.burner_phone_context.format([message.replace("\n", " ")])
	Websocket.send(Context.new(context, true))

static func UserDeath_EnterSpectatorMode_prefix(player: MP_UserInstanceProperties) -> void:
	var context := MpStrings.self_died_context if player.is_active else MpStrings.other_died_context.format([player.user_name])
	Websocket.send(Context.new(context, false))

# only called for beer
static func InteractWithItem_FirstPerson_patch(instance: MP_ItemInteraction, is_live: bool) -> void:
	await instance.get_tree().create_timer(3).timeout
	var shell = SpStrings.live if is_live else SpStrings.blank
	var context = SpStrings.beer_context.format([shell])
	Websocket.send(Context.new(context, false))

# only called for beer
static func InteractWithItem_ThirdPerson_patch(instance: MP_ItemInteraction, packet: Dictionary, is_live: bool, name: String) -> void:
	await instance.get_tree().create_timer(2).timeout
	var shell = SpStrings.live if is_live else SpStrings.blank
	var item_desc = SpStrings.beer_description.format([shell])

	var args = [name, "beer", item_desc]
	var theft_victim = _get_theft_victim(instance.properties.intermediary.instance_handler, packet)
	if theft_victim:
		args[1] = theft_victim + " " + args[1]

	var context = MpStrings.other_used_item_context.format(args)
	Websocket.send(Context.new(context, false))

static func Hand_PickupItem_prefix(instance: MP_HandManager, active_id: int, packet: Dictionary) -> void:
	var item_name: String
	var item_desc: String

	match active_id:
		1: # hand saw
			item_name = "handsaw"
			item_desc = SpStrings.saw_description
		2: # magnifying glass
			item_name = "magnifying glass"
			item_desc = SpStrings.magnifying_glass_description
		3: # jammer
			item_name = "jammer"
			item_desc = MpStrings.jammer_description
		4: # cigs
			item_name = "cigarettes"
			item_desc = SpStrings.cigar_description
		5: # beer
			return # This context is sent somewhere else
		6: # burner phone
			item_name = "burner phone"
			item_desc = MpStrings.burner_phone_description
		8: # adrenaline
			item_name = "adrenaline"
			item_desc = MpStrings.adrenaline_description
		9: # inverter
			item_name = "inverter"
			item_desc = SpStrings.inverter_description
		10: # remote
			item_name = "remote"
			var order := MpStrings.remote_description_cw if instance.properties.intermediary.game_state.MAIN_active_turn_order == "CW" else MpStrings.remote_description_ccw
			item_desc = MpStrings.remote_description.format([order])

	var theft_victim = _get_theft_victim(instance.properties.intermediary.instance_handler, packet)
	if theft_victim:
		item_name = theft_victim + " " + item_name

	var context = MpStrings.other_used_item_context.format([instance.properties.user_name, item_name, item_desc])
	Websocket.send(Context.new(context, true))

static func GiveTurnPermissions_patch(user: MP_UserInstanceProperties) -> void:
	if user.is_active:
		return

	var context = MpStrings.other_turn_start_context.format([user.user_name])
	Websocket.send(Context.new(context, true))

static func Jammer_Check_prefix(instance: MP_Jammer) -> void:
	var name = SpStrings.player_pronoun_possessive if instance.properties.is_active else instance.properties.user_name + "'s"
	var context = SpStrings.turn_skipped_context.format([name])
	Websocket.send(Context.new(context, !instance.properties.is_active))

static func Jammer_Enable_prefix(instance: MP_Jammer) -> void:
	var context: String
	if instance.properties.is_active:
		context = MpStrings.self_just_jammed_context
	else:
		var name = instance.properties.user_name + "'s"
		context = MpStrings.other_just_jammed_context.format([name])
	Websocket.send(Context.new(context, !instance.properties.is_active))

static func GrabBriefcase_FirstPerson_patch(instance: MP_BriefcaseMachine) -> void:
	await instance.get_tree().create_timer(3).timeout
	var context = MpStrings.grab_briefcase_self_context
	Websocket.send(Context.new(context, false))

static func GrabBriefcase_ThirdPerson_patch(instance: MP_BriefcaseMachine) -> void:
	await instance.get_tree().create_timer(3).timeout
	var context = MpStrings.grab_briefcase_other_context.format([instance.properties.user_name])
	Websocket.send(Context.new(context, false))

static func ShowMatchResults_patch(instance: MP_OutroManager) -> void:
	var text := "MATCH RESULTS:\n"
	text += instance.tr("MP_UI MOST DAMAGE") + "... " + instance.label_most_damage.get_child(2).text + "\n"
	text += instance.tr("MP_UI MOST DEATHS") + "... " + instance.label_most_deaths.get_child(2).text + "\n"
	text += instance.tr("MP_UI THE CHIMNEY") + "... " + instance.label_the_chimney.get_child(2).text + "\n"
	text += instance.tr("MP_UI LEAST CAREFUL") + "... " + instance.label_least_careful.get_child(2).text + "\n"
	text += instance.tr("MP_UI MOST RESOURCEFUL") + "... " + instance.label_most_resourceful.get_child(2).text + "\n"
	text += instance.tr("MP_UI THE WEALTHIEST") + "... " + instance.label_the_wealthiest.get_child(2).text

	var context := MpStrings.game_end_context.format([text])
	Websocket.send(Context.new(context, false))

static func _get_theft_victim(instance_handler: MP_UserInstanceHandler, packet: Dictionary) -> String:
	if not packet.stealing_item:
		return ""

	var socket: int = packet.item_socket_number
	var stolen_from := "someone"
	for user_property in instance_handler.instance_property_array:
		if user_property.socket_number == socket:
			if user_property.is_active:
				stolen_from = SpStrings.player_pronoun_possessive.to_lower()
			else:
				stolen_from = user_property.user_name + "'s"
			break
	return stolen_from
