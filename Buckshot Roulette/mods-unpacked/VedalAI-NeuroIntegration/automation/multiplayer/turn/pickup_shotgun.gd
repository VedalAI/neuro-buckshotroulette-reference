class_name PickupShotgun
extends NeuroAction

var _shotgun: MP_ShotgunInteraction

func _init(action_window: ActionWindow, shotgun: MP_ShotgunInteraction):
	super(action_window)
	_shotgun = shotgun

func _get_name() -> String:
	return "pickup_shotgun"

func _get_description() -> String:
	return MpStrings.pickup_shotgun_action_description

func _get_schema() -> Dictionary:
	return {}

func _validate_action(_data: IncomingData, _state: Dictionary) -> ExecutionResult:
	return ExecutionResult.success()

func _execute_action(_state: Dictionary) -> void:
	_shotgun.PickupShotgun()
