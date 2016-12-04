SnakeAIAttack = SnakeAIAttack or BaseClass()
function SnakeAIAttack:__init(period)
	self.period = period
	local function TimerCallBack( ... )
		self:Update()
	end
	TimerManager.Instance:AddTimer(Timer.New(self.period, -1,  TimerCallBack))
end

function SnakeAIAttack:Update()
	
end

SnakeAIEat = SnakeAIEat or BaseClass()
function SnakeAIEat:__init(period)
	self.period = period
	local function TimerCallBack()
		self:Update()
	end
	SnakeCtrl.Instance:SetAI("Player")
	TimerManager.Instance:AddTimer(Timer.New(self.period, -1,  TimerCallBack))
end

function SnakeAIEat:Update()
	ProtocalSnake.Instance:RequireMove(SnakeCtrl.Instance:GetNextStep())
end

SnakeAIWalk = SnakeAIWalk or BaseClass()
function SnakeAIWalk:__init(period)
	self.period = period
	self.target = nil
	local function TimerCallBack()
		self:Update()
	end	
	SnakeCtrl.Instance:SetAI("Walk")	
	TimerManager.Instance:AddTimer(Timer.New(self.period, -1,  TimerCallBack))
end

function SnakeAIWalk:GetTarget()
	self.target = {}
	self.target.x = math.random(100)%Config.Snake.MAX_X  + 1
	self.target.y = math.random(100)%Config.Snake.MAX_Y  + 1
end
function SnakeAIWalk:Update()
	if not self.target then 
		self:GetTarget()
	end
	local next_dir, over = SnakeCtrl.Instance:GetNextStep(self.target.x, self.target.y)
	if over then 
		self:GetTarget()
	end
	ProtocalSnake.Instance:RequireMove(next_dir)
end

SnakeAITarget = SnakeAITarget or BaseClass()
function SnakeAITarget:__init(period)
	self.target = nil
	self.period = period
	local function TimerCallBack()
		self:Update()
	end
	SnakeCtrl.Instance:SetAI("Follow")	
	TimerManager.Instance:AddTimer(Timer.New(self.period, -1,  TimerCallBack))
end

function SnakeAITarget:GetTarget()
	local posx, posy = SnakeCtrl.Instance:GetSnakePos()
	local list = SnakeCtrl.Instance:GetSnakeList()
	local distance = 100000000

	local target_list = {}
	for k,v in pairs(list) do
		if Player.Instance.player_id ~= v.id and self.target ~= v.id  then
			table.insert(target_list, v)
		end
	end
	for k,v in pairs(target_list) do
		local dis = math.abs(posx - v.x) + math.abs(posy - v.y)
		if dis < distance then 
			distance = dis
			self.target = v.id
		end
	end
end

function SnakeAITarget:Update()
	if not self.target then 
		self:GetTarget()
		return
	end

	local posx, posy = SnakeCtrl.Instance:GetSnakePos()
	local list = SnakeCtrl.Instance:GetSnakeList()
	local snake = nil
	for k,v in pairs(list) do
		if v.id == self.target then 
			local dis = math.abs(posx - v.x) + math.abs(posy - v.y)
			if dis <= 1 then 
				self:GetTarget()
				return
			end
			ProtocalSnake.Instance:RequireMove(SnakeCtrl.Instance:GetNextStep(v.x, v.y))
			break
		end
	end
	
	
end