require "SnakeLogic"

Player = Player or BaseClass()

function Player:__init(id)
	self.user_id = id
	self.logic_list = {}
	
	self:Init()
end

function Player:Init()
	self.snake_logic = SnakeLogic.New(self)
	self:RegistLogic(self.snake_logic)	
end

function Player:RegistLogic(logic)
	table.insert(self.logic_list, logic)
end

function Player:OnUserLogin()
	for k,v in pairs(self.logic_list) do
		v["OnUserLogin"](v)
	end
end

function Player:OnUserLogout()
	for k,v in pairs(self.logic_list) do
		v["OnUserLogout"](v)
	end
end

function Player:Send(msg)
	ServerNetWork.Instance:Send(self.user_id, msg)
end

function Player:BroadCast(msg)
	ServerNetWork.Instance:BroadCast(msg)
end

function Player:GetUserID()
	return self.user_id
end

function Player:GetSnakeLogic()
	return self.snake_logic
end
