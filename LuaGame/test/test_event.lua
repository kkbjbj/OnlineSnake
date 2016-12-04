TestEvent = TestEvent or BaseClass()

function TestEvent:__init()
	if TestEvent.Instance ~= nil then
		error("attempt to create singleton TestEvent twice!")
	end
	TestEvent.Instance = self	
	
	self.EventHandle = function( ... )
		self:OnEvent(...)
	end
	EventManager.Instance:AddListener("update", self.EventHandle)
end

function TestEvent:OnEvent( ... )
	self.count = self.count or 0
	self.count = self.count + 1
	print("TestEvent", self.count)
	if self.count >= 3 then 
		EventManager.Instance:RemoveListener("update", self.EventHandle)
	end
end