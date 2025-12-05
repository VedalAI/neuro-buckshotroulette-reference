class_name SpHeavenExtension

static func BeginLoop_postfix(instance: Heaven) -> void:
	instance.Fly()

static func Fly_postfix(instance: Heaven) -> void:
	await instance.get_tree().create_timer(2).timeout
	instance.Button_Retry()
