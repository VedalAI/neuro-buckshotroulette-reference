class_name Log

static func debug(message: String):
	ModLoaderLog.debug(message, ModMain.NAME)

static func info(message: String):
	ModLoaderLog.info(message, ModMain.NAME)

static func warning(message: String):
	ModLoaderLog.warning(message, ModMain.NAME)

static func error(message: String):
	ModLoaderLog.error(message, ModMain.NAME)

static func fatal(message: String):
	ModLoaderLog.fatal(message, ModMain.NAME)
