class_name IHateAlgorithms

static func get_closest_by_levenshtein_distance(items: Array, selector_func: Callable, target: String, max_distance_inclusive: int) -> Variant:
	var closest_distance := max_distance_inclusive + 1
	var closest_item: Variant = null

	for item in items:
		var string: String = selector_func.call(item)
		var distance := _levenshtein_distance(string, target)
		if distance < closest_distance:
			closest_distance = distance
			closest_item = item

	return closest_item

static func _levenshtein_distance(str1: String, str2: String) -> int:
	var len1 = str1.length()
	var len2 = str2.length()

	# Create a matrix (2D array) to store the distances
	var matrix = []

	# Initialize the matrix
	for i in range(len1 + 1):
		matrix.append([])
		for j in range(len2 + 1):
			matrix[i].append(0)

	# Fill the first row and first column
	for i in range(len1 + 1):
		matrix[i][0] = i
	for j in range(len2 + 1):
		matrix[0][j] = j

	# Compute the Levenshtein distance
	for i in range(1, len1 + 1):
		for j in range(1, len2 + 1):
			var cost = 0
			if str1[i - 1] != str2[j - 1]:
				cost = 1

			matrix[i][j] = min(matrix[i - 1][j] + 1,   # Deletion
								matrix[i][j - 1] + 1,   # Insertion
								matrix[i - 1][j - 1] + cost)  # Substitution

	# The result is in the bottom-right corner of the matrix
	return matrix[len1][len2]
