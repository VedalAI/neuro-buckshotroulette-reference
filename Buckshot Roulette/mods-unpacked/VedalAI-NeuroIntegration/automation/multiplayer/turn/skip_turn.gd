class_name SkipTurn
extends NeuroAction

var _jammer: MP_Jammer

func _init(action_window: ActionWindow, jammer: MP_Jammer):
	super(action_window)
	_jammer = jammer

func _get_name() -> String:
	return "skip_turn"

func _get_description() -> String:
	return MpStrings.skip_turn_action_description

func _get_schema() -> Dictionary:
	return JsonUtils.wrap_schema({
		"player": {
			"enum": _get_targets().keys()
		}
	})

func _validate_action(data: IncomingData, state: Dictionary) -> ExecutionResult:
	var player: String = data.get_string("player")
	if not player:
		return ExecutionResult.failure(SpStrings.action_failed_missing_required_parameter.format(["player"]))

	var targets := _get_targets()
	var closest_target: String = IHateAlgorithms.get_closest_by_levenshtein_distance(targets.keys(), func(key: String) -> String: return key, player, 3)

	if not closest_target:
		return ExecutionResult.failure(SpStrings.action_failed_invalid_parameter.format(["player"]))

	var socket: int = targets[closest_target]

	state["target"] = socket
	return ExecutionResult.success()

func _execute_action(state: Dictionary) -> void:
	var socket: int = state["target"]
	if socket == 0: socket = 1
	elif socket == 1: socket = 0
	var branch :=  _jammer.button_intbranches[socket]
	var jammer_button: MP_JammerButton = branch.get_parent().get_child(0)
	await jammer_button.Press()

	await _jammer.get_tree().create_timer(0.5).timeout

	var confirm_branch := _jammer.button_intbranches[3]
	var confirm_button: MP_JammerButton = confirm_branch.get_parent().get_child(0)
	await confirm_button.Press()

func _get_targets() -> Dictionary:
	var directions: Array[String] = ["left", "forward", "right"]

	var result := {}
	for i in range(_jammer.valid_target_array.size()):
		if not _jammer.valid_target_array[i]:
			continue # no player to skip

		var user_name: String = _jammer.properties.GetSocketProperties(_jammer.properties.GetSocketFromDirection(_jammer.properties.socket_number, directions[i])).user_name
		result[user_name] = i

	return result
