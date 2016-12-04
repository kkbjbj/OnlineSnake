
EventManager = EventManager or BaseClass()

local EventLib = require "basetool.eventlib"

function EventManager:__init()
	if EventManager.Instance ~= nil then
		error("attempt to create singleton EventManager twice!")
	end
	EventManager.Instance = self

	self.events = {}
end

function EventManager:AddListener(event,handler)
	if not event or not handler then 
		return 
	end

	if not self.events[event] then		
		self.events[event] = EventLib:new(event)
	end

	self.events[event]:connect(handler)
end

function EventManager:Fire(event,...)
	if not self.events[event] then
		return
	else
		self.events[event]:fire(...)
	end
end

function EventManager:RemoveListener(event,handler)
	if not self.events[event] then
		return
	else
		self.events[event]:disconnect(handler)
	end
end
