TestTimer = TestTimer or BaseClass()

function TestTimer:__init()
	if TestTimer.Instance ~= nil then
		error("attempt to create singleton TestTimer twice!")
	end
	TestTimer.Instance = self	
	self:AddTimer()
end

TestTimerCallBack = TestTimerCallBack or BaseClass(TimerCallBack)
function TestTimerCallBack:__init(snake_test)
	self.count = 0
end

function TestTimerCallBack:Run()
	self.count = self.count + 1
	print("TestTimer Run "..self.count.." Times")	
end

function TestTimer:AddTimer()
	TimerManager.Instance:AddTimer(Timer.New(1, 3, TestTimerCallBack.New(self)))
end