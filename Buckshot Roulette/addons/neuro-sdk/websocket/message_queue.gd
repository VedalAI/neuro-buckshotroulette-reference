class_name MessageQueue

var _messages: Array[OutgoingMessage] = [Startup.new()]

func size() -> int:
	return _messages.size()

func enqueue(message: OutgoingMessage) -> void:
	for existing_message in _messages:
		if existing_message.merge(message):
			return
	_messages.append(message)

func dequeue() -> OutgoingMessage:
	if size() == 0:
		return null

	var message := _messages[0]
	_messages.remove_at(0)

	return message
