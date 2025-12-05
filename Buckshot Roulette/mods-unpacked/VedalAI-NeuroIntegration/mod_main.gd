class_name ModMain
extends Node

const NAME := "VedalAI-NeuroIntegration"

func _init() -> void:
	add_child(CursorVisibility.new())
	add_child(GlobalNode.new())
	add_child(NeuroActionHandler.new())
	add_child(ProperInput.new())
