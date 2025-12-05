class_name Shoot
extends NeuroAction

var _shotgun: ShotgunShooting

func _init(action_window: ActionWindow, shotgun: ShotgunShooting):
	super(action_window)
	_shotgun = shotgun

func _get_name() -> String:
	return "shoot"

func _get_description() -> String:
	return SpStrings.shoot_action_description

func _get_schema() -> Dictionary:
	return JsonUtils.wrap_schema({
		"target": {
			"enum": ["self", "dealer"]
		}
	})

func _validate_action(data: IncomingData, state: Dictionary) -> ExecutionResult:
	var target := data.get_string("target")
	if not target:
		return ExecutionResult.failure(SpStrings.action_failed_missing_required_parameter.format(["target"]))

	if target != "self" and target != "dealer":
		return ExecutionResult.failure(SpStrings.action_failed_invalid_parameter.format(["target"]))

	state["target"] = target
	return ExecutionResult.success()

func _execute_action(state: Dictionary) -> void:
	var shooting_choice_node := GlobalNode.get_node_("/root/main/ui parent_shooting decision")
	var dealer: TextInteraction = shooting_choice_node.get_node("text dealer/ui branch")
	var player: TextInteraction = shooting_choice_node.get_node("text you/ui branch")
	dealer.colorvalue_min = 0.7
	dealer.colorvalue_max = 0.7
	dealer.colorvalue_current = 0.7
	dealer.colorvalue_next = 0.7
	dealer.text.modulate = Color(0.7, 0.7, 0.7, dealer.text.modulate.a)
	player.colorvalue_min = 0.7
	player.colorvalue_max = 0.7
	player.colorvalue_current = 0.7
	player.colorvalue_next = 0.7
	player.text.modulate = Color(0.7, 0.7, 0.7, player.text.modulate.a)

	_shotgun.GrabShotgun()
	await _shotgun.get_tree().create_timer(1).timeout

	_shotgun.Shoot(state["target"])
	_shotgun.decisionText.SetUI(false)
