class_name Traverse

static func directory(path: String) -> Array[String]:
	var dir := DirAccess.open(path)

	var files: Array[String] = []

	dir.list_dir_begin()
	var file_name := dir.get_next()
	while file_name != "":
		var file_path := path.path_join(file_name)

		if dir.current_is_dir():
			files.append_array(directory(file_path))
		else:
			files.append(file_path)

		file_name = dir.get_next()

	dir.list_dir_end()

	return files

static func directories(paths: Array[String]) -> Array[String]:
	var files: Array[String] = []

	for path in paths:
		files.append_array(directory(path))

	return files
