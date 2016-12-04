Timer = Timer or BaseClass()

function Timer:__init(period, times, callback)
	self.period = period
	self.times = times
	self.callback = callback

	self.next_active = 0
	self.cur_run_times = 0
end

function Timer:OnTimer()
	if type(self.callback) == "function" then
		self.callback()
	else
		self.callback:Run()
	end
	self.cur_run_times = self.cur_run_times + 1
	self.next_active = self.next_active + self.period
end

function Timer:OnAdded()
	self.next_active = GetTime() + self.period
end

function Timer:SetNextActiveTime()
	self.next_active = self.next_active + self.period
end

function Timer:CheckValid()
	return self.period > 0
end

function Timer:CheckTimeUp(cur_time)
	return cur_time > self.next_active
end

function Timer:IsOver()
	if self.times < 0 then 
		return false
	else 
		return self.cur_run_times >= self.times
	end
end