ProtocalPlayer = ProtocalPlayer or BaseClass(ProtocalBase)

function ProtocalPlayer:__init()
	ProtocalPlayer.Instance = self
	self:RegisterProtocal(0, "OnServerAccept")
	self:RegisterProtocal(1, "OnMsg")
end

function ProtocalPlayer:OnServerAccept(massage)
	Player.Instance:SetPlayerID(massage.playerID)
end

function ProtocalPlayer:OnMsg(massage)
	print(massage)
end