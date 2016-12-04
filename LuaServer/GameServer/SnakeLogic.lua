SnakeLogic = SnakeLogic or BaseClass()

SnakeLogic.MAX_X = Config.SNAKE_MAX_X
SnakeLogic.MAX_Y = Config.SNAKE_MAX_Y

function SnakeLogic:__init(player)
	self.player = player
	self.posx = 1
	self.posy = math.random(100)%(GlobalSnakelogic.MAX_Y - 5)
	self.score = 0
end

function SnakeLogic:OnUserLogin()
	self:OnSnakeMove(4)
end

function SnakeLogic:OnUserLogout()

end

function SnakeLogic:OnSnakeMove(dir)
	local oldx, oldy = self.posx, self.posy
	if dir == 1 then 
		if self.posx > 1 then 
			self.posx = self.posx - 1
		end
	elseif dir == 2 then 
		if self.posx < SnakeLogic.MAX_X then 
			self.posx = self.posx + 1
		end
	elseif dir == 3 then
		if self.posy > 1 then 
			self.posy = self.posy - 1
		end
	elseif dir == 4 then
		if self.posy < SnakeLogic.MAX_Y then 
			self.posy = self.posy + 1
		end
	end

	if oldx~= self.posx or oldy ~= self.posy then 
		-- local msg = MsgSnakePos.New(self.posx, self.posy)
		-- self.player:Send(msg:GetJson())
		GlobalLogicManager.Instance:OnSnakeMove(self.player:GetUserID(), self.posx, self.posy)
	end
end

