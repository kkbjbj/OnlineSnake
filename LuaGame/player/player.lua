Player = Player or BaseClass()

function Player:__init()
	if Player.Instance ~= nil then
		error("Singleton error class:  Player")
	end
	Player.Instance = self
end

function Player:GetName()
	print("Player")
end

function Player:SetPlayerID(id)
	self.player_id = id
end