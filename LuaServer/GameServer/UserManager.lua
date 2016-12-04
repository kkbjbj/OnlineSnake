require "player"

UserManager = UserManager or BaseClass()

function UserManager:__init()
	if UserManager.Instance ~= nil then
		error("attempt to create singleton UserManager twice!")
	end
	UserManager.Instance = self
	self.user_list = {}
end

function UserManager:OnUserLogin(id)
	local player = Player.New(id)
	self.user_list[id] = player
	player:OnUserLogin()
end

function UserManager:OnUserLogout(id)
	local player = self.user_list[id]
	if player then
		player:OnUserLogout()
		GlobalLogicManager.Instance:OnUserLogout(id)
		self.user_list[id] = nil
	end
end

function UserManager:GetPlayer(id)
	return self.user_list[id]
end