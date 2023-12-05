class_name bus

static var eventHandlerRegister = {}

static func registerHandler(eventType: String, handler: Callable):
	if (!eventHandlerRegister.has(eventType)): 
		eventHandlerRegister[eventType] = []
	eventHandlerRegister[eventType].append(handler)

static func unregisterHandler(eventType: String):
	eventHandlerRegister.remove(eventType)

static func postEvent(eventType, data):
	if(eventHandlerRegister.has(eventType)): 
		for m in eventHandlerRegister[eventType]:
			m.call(data)
