class_name MenuExtension

static func Intro_postfix(instance: MenuManager) -> void:
	instance.SkipIntro()

	await instance.get_tree().create_timer(1).timeout

	if Input.is_key_pressed(KEY_S):
		return

	var args: PackedStringArray = OS.get_cmdline_args()
	if args.has("--singleplayer"):
		instance.Start()
	elif args.has("--multiplayer"):
		instance.StartMultiplayer()
