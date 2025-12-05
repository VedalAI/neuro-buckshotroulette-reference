class_name SpEndExtension

static func MainRoutine_postfix(instance: BriefcaseMachine) -> void:
	instance.OpenLatch("L")
	await instance.get_tree().create_timer(0.7).timeout
	instance.OpenLatch("R")
	await instance.get_tree().create_timer(0.7).timeout
	instance.OpenLid()
