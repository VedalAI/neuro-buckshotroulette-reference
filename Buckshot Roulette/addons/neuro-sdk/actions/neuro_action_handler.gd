class_name NeuroActionHandler
extends Node

static var _instance: NeuroActionHandler
var _registered_actions: Array[NeuroAction] = []
var _dying_actions: Array[NeuroAction] = []

func _init():
	_instance = self

func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		var array: Array[WsAction] = []
		array.assign(_registered_actions.map(func(action: NeuroAction) -> WsAction: return action.get_ws_action()))
		Websocket.send_immediate(ActionsUnregister.new(array))

static func get_action(action_name: String) -> NeuroAction:
	var actions: Array = _instance._registered_actions.filter(func(action: NeuroAction) -> bool: return action.get_name() == action_name)
	if actions.size() == 0:
		return null

	return actions[0]

static func is_recently_unregistered(action_name: String) -> bool:
	return _instance._dying_actions.any(func(action: NeuroAction) -> bool: return action.get_name() == action_name)

static func register_actions(actions: Array[NeuroAction]):
	_instance._registered_actions = _instance._registered_actions.filter(func(old_action: NeuroAction) -> bool: return not actions.any(func(new_action: NeuroAction) -> bool: return old_action.get_name() == new_action.get_name()))
	_instance._dying_actions = _instance._dying_actions.filter(func(old_action: NeuroAction) -> bool: return not actions.any(func(new_action: NeuroAction) -> bool: return old_action.get_name() == new_action.get_name()))
	_instance._registered_actions.append_array(actions)

	var array: Array[WsAction] = []
	array.assign(actions.map(func(action: NeuroAction) -> WsAction: return action.get_ws_action()))
	Websocket.send(ActionsRegister.new(array))

static func unregister_actions(actions: Array[NeuroAction]):
	var actions_to_remove: Array[NeuroAction] = _instance._registered_actions.filter(func(old_action: NeuroAction) -> bool: return actions.any(func(new_action: NeuroAction) -> bool: return old_action.get_name() == new_action.get_name()))

	_instance._registered_actions = _instance._registered_actions.filter(func(old_action: NeuroAction) -> bool: return not actions_to_remove.has(old_action))
	_instance._dying_actions.append_array(actions_to_remove)

	var array: Array[WsAction] = []
	array.assign(actions_to_remove.map(func(action: NeuroAction) -> WsAction: return action.get_ws_action()))
	Websocket.send(ActionsUnregister.new(array))

	await _instance.get_tree().create_timer(10).timeout
	_instance._dying_actions = _instance._dying_actions.filter(func(action: NeuroAction) -> bool: return actions_to_remove.has(action))

static func resend_registered_actions():
	var array: Array[WsAction] = []
	array.assign(_instance._registered_actions.map(func(action: NeuroAction) -> WsAction: return action.get_ws_action()))
	if array.size() > 0:
		Websocket.send(ActionsRegister.new(array))
