class_name bus

static var eventHandlerRegister = {}

static func registerHandler(eventType: String, handler: Callable):
	print_debug(eventType, handler)
	if (!eventHandlerRegister.has(eventType)): 
		eventHandlerRegister[eventType] = []
	eventHandlerRegister[eventType].append(handler)
	print_debug(eventHandlerRegister)

static func unregisterHandler(eventType: String):
	eventHandlerRegister.remove(eventType)

static func postEvent(eventType, data):
	print_debug(eventHandlerRegister)
	if(eventHandlerRegister.has(eventType)): 
		for m in eventHandlerRegister[eventType]:
			print_debug(m)
			m.call(data)


static func printRegister():
	print_debug(eventHandlerRegister)
