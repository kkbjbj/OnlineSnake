require "basetool.timer.timer"
require "basetool.timer.timer_callback"

TimerManager = TimerManager or BaseClass()

function TimerManager:__init()
	if TimerManager.Instance ~= nil then
		error("attempt to create singleton TimerManager twice!")
	end
	TimerManager.Instance = self

	self.timer_list = {}
end

function TimerManager:AddTimer(timer)
	if timer:CheckValid() then 
		timer:OnAdded()
		table.insert(self.timer_list, timer)
	end
end

function TimerManager:Update()
	local cur_time = GetTime()
	for k,v in pairs(self.timer_list) do
		if not v:IsOver() then
			if v:CheckTimeUp(cur_time) then 
				v:OnTimer()
			end
		end
	end
end