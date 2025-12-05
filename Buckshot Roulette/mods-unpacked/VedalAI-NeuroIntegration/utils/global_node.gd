class_name GlobalNode
extends Node

static var _instance: GlobalNode

func _init():
	_instance = self

static func get_node_(path: String) -> Node:
	return _instance.get_node(path)

static func get_tree_() -> SceneTree:
	return _instance.get_tree()
