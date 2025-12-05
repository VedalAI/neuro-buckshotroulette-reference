class_name ChooseName
extends NeuroAction

var _signature_manager: Signature

func _init(action_window: ActionWindow, signature_manager: Signature):
	super(action_window)
	_signature_manager = signature_manager

func _get_name() -> String:
	return "choose_name"

func _get_description() -> String:
	return SpStrings.choose_name_action_description

func _get_schema() -> Dictionary:
	return JsonUtils.wrap_schema({
		"name": {
			"type": "string",
			"minLength": 1,
			"maxLength": 6,
			"pattern": "^[A-Z]+$"
		}
	})

func _validate_action(data: IncomingData, state: Dictionary) -> ExecutionResult:
	var name := data.get_string("name").to_lower()
	if not name:
		return ExecutionResult.failure(SpStrings.action_failed_missing_required_parameter.format(["name"]))

	if len(name) < 1 or len(name) > 6:
		return ExecutionResult.failure(SpStrings.choose_name_action_failed_invalid_name)

	for i in range(len(name)):
		var letter := name[i]
		if letter < "a" or letter > "z":
			return ExecutionResult.failure(SpStrings.choose_name_action_failed_invalid_name)

	if name == "god" or name == "dealer":
		return ExecutionResult.failure(SpStrings.choose_name_action_failed_forbidden_name)

	state["name"] = name
	return ExecutionResult.success()

func _execute_action(state: Dictionary) -> void:
	var parent := GlobalNode.get_node_("/root/main/signature machine2/signature machine main parent/baseplate main/button colliders parent/button colliders sub-parent")
	var name: String = state["name"]
	for i in range(len(name)):
		var letter := name[i]
		var button: SignButton = parent.get_node("button_%s/signature button branch" % [letter])
		_signature_manager.GetInput(letter, "")
		await button.Press()
		await GlobalNode.get_tree_().create_timer(0.2).timeout

	var enter_button: SignButton = parent.get_node("button_enter/signature button branch")
	_signature_manager.GetInput("", "enter")
	enter_button.Press()
