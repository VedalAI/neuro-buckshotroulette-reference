class_name ShootMp
extends NeuroAction

var _shotgun: MP_ShotgunInteraction

func _init(action_window: ActionWindow, shotgun: MP_ShotgunInteraction):
	super(action_window)
	_shotgun = shotgun

func _get_name() -> String:
	return "shoot"

func _get_description() -> String:
	return MpStrings.shoot_action_description

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

	var branch: MP_InteractionBranch = targets[closest_target]

	state["target"] = branch
	return ExecutionResult.success()

func _execute_action(state: Dictionary) -> void:
	_shotgun.Shoot(state["target"])

func _get_targets() -> Dictionary:
	var result := {}
	for _prop in _shotgun.intermediary.roundManager.instance_handler.instance_property_array:
		var prop: MP_UserInstanceProperties = _prop
		if prop.health_current == 0:
			continue # dont shoot dead players
		var key := prop.user_name if not prop.is_active else "self"
		result[key] = prop.hover_pan.intbranch
	return result
